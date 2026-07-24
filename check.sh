#!/usr/bin/env bash
# Enforces the mechanical rules from SKILL.md's own "Maintaining This Skill"
# section. Runs in CI; run it yourself before committing an edit.
set -u

SKILL="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/SKILL.md"
SIGNAL_MARK=16384
BUDGET=$SIGNAL_MARK
FAIL=0

pass() { echo "  ok    $1"; }
fail() { echo "  FAIL  $1"; FAIL=$((FAIL+1)); }
warn() { echo "  warn  $1"; }

echo "checking SKILL.md"

# 1. Size is a SIGNAL, not a limit. Passing the mark means go looking for
#    duplication - two rules covering one mechanism, or a narrative that crept
#    back in. It never means cut load-bearing content to hit a number.
#    Deduplicating and generalizing shrink a file safely; trimming does not.
SIZE=$(wc -c < "$SKILL")
if [ "$SIZE" -le "$BUDGET" ]; then
    pass "size ${SIZE}B (signal mark ${BUDGET}B)"
else
    warn "size ${SIZE}B is past the ${BUDGET}B signal mark - look for duplication, do not trim to fit"
fi

# 2. Required structure. A missing section means someone restructured
#    without reading the maintenance rules.
for section in "## Standing Prohibition" "## Protocol A" "## Protocol B" \
               "### Rationalization Families" "## Maintaining This Skill" \
               "## Verification Tool Order"; do
    if grep -qF "$section" "$SKILL"; then
        pass "section present: $section"
    else
        fail "section missing: $section"
    fi
done

# 3. Family count. New families should be rare; a jump means incidents are
#    being appended as families instead of folded into existing ones.
FAMILIES=$(awk '/^### Rationalization Families/{f=1; next} f && /^#{2,3} /{f=0} f && /^\*\*[0-9]+\. /{c++} END{print c+0}' "$SKILL")
if [ "$FAMILIES" -eq 8 ]; then
    pass "8 rationalization families"
else
    fail "expected 8 families, found $FAMILIES - a new family needs a new mechanism, not a new incident"
fi

# 4. Frontmatter must be intact and name the skill.
if head -1 "$SKILL" | grep -q '^---$' && grep -q '^name: bitch-stop-lyin$' "$SKILL"; then
    pass "frontmatter intact"
else
    fail "frontmatter missing or renamed"
fi

# 5. No incident narratives. The maintenance rule says stories go in commit
#    messages; a long paragraph inside a family is how the 33KB happened.
LONG=$(awk '/^\*\*[0-9]+\. /{ if (length($0) > 1200) print NR }' "$SKILL" | wc -l)
if [ "$LONG" -eq 0 ]; then
    pass "no over-long family entries"
else
    fail "$LONG family entry/entries over 1200 chars - fold the narrative into the commit message"
fi

echo ""
if [ "$FAIL" -eq 0 ]; then
    echo "all checks passed"
else
    echo "$FAIL check(s) failed"
fi
exit "$FAIL"
