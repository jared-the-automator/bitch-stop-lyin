# bitch-stop-lyin

A verification gate for AI coding agents. It stops the agent from telling you
things it never checked.

Drop-in skill for [Claude Code](https://claude.com/claude-code). The ideas
port to any agent harness that accepts a system prompt.

---

## The problem

Your agent tells you to open Settings, then Integrations, then click "Add
Account." The menu says something else. The tab moved two releases ago. You
lose twenty minutes before you work out that the confident, specific,
plausible instructions were generated from training data and never checked
against anything.

That failure has a shape. The agent almost never decides to make something
up. It reaches for a fact that feels solid, and the feeling of solidity is
the whole problem, because familiar platforms are exactly where training data
rots fastest. You have no reason to doubt a thing you have "known" for two
years.

Telling a model "don't hallucinate" does nothing. Telling it "verify before
you claim" does a little. What works is naming the specific excuse it uses to
skip the check, because the excuse always arrives as a reasonable thought.

## What this does

Two protocols, both firing on what the agent is about to output rather than
on what you typed. That distinction carries most of the value. A gate keyed
to your input misses the claim the agent volunteers in a closing paragraph,
which is where a lot of the bad ones live.

**Protocol A** covers scope and estimates. Six steps, an explicit assumption
ledger, three numbers instead of one. No point estimate survives while an
assumption is still unverified.

**Protocol B** covers technical claims about named external systems. Every
claim gets checked against current docs first. No exempt document types, no
"I know this one" list, and no home-turf exemption, so the agent has to
verify claims about its own product surface the same as anyone else's.

## The six rationalization families

The rules matter less than the taxonomy of excuses. Every verification skip
this thing has caught reduces to one of six thoughts:

**1. No exempt frame.** "This is conversational." "It's a proposal, not a
spec." "I'm only summarizing what we already established." "Nobody even asked
for this, I volunteered it." Position, register, document type, and
authorship change nothing. Restating an unverified claim creates a fresh
unverified claim.

**2. A hedge is a confession.** The moment you write "usually," or "(or
similar)," or "click Export or maybe Download," you have admitted you are
guessing. That admission is the trigger to go check, not a license to publish
with a softener attached. Two candidate names for one button means you never
looked.

**3. Inference is not observation.** "The call failed, so the service is
down." A mechanism you deduced from symptoms is a hypothesis wearing a fact's
clothing. Trace the code path, or write "Hypothesis, unverified" and keep
moving.

**4. Familiarity is the alarm, not the clearance.** The platforms you know
best are where your information is stalest, and the ones you will never think
to check. Pricing and compliance policies change quietly and feel permanent.

**5. Borrowed verification isn't yours.** A subagent returned citations, so
the claim feels checked. It isn't. Two correctly-cited numbers combined into
a comparison produce a third claim nobody verified, and units that were never
confirmed comparable.

**6. No number without a source.** A statistic that happens to support your
argument is evidence you built it. Cite it or cut it.

Naming the families is what makes this work on smaller models. Thirty-four
individual war stories are not retrievable mid-response. Six named patterns
are.

## Install

```bash
git clone https://github.com/jared-the-automator/bitch-stop-lyin.git
cp -r bitch-stop-lyin ~/.claude/skills/
```

The directory name becomes the invocation name, so rename it to taste. The
skill has no dependencies and needs no configuration.

For other harnesses, paste `SKILL.md` into your system prompt or rules file.
See [docs/ADAPTING.md](docs/ADAPTING.md) for Cursor, Copilot, and raw API
use.

## The compression story

This file grew to 33KB, about 8,000 tokens on every single load. Each new
caught failure got appended as a fresh red flag containing the full narrative
of the incident behind it. Fifteen rounds of that. Five of the flags restated
entire sections that already existed elsewhere in the same document.

Compressing to 15KB cut the per-load cost by 54 percent and lost no rules,
which I verified by probing the new text for all 42 distinct concepts in the
old one. The incident narratives moved into git history where they belong.

The transferable lesson runs against the instinct. A behavioral skill that
grows by appending one story per incident will decay into something too long
to follow, and the decay is invisible because every individual addition looks
justified. Fold new failures into existing families. Put the story in the
commit message.

`archive/2026-07-14-pre-compression.md` holds the original 33KB text. Read it
next to `SKILL.md` if you want to see what 34 narrative red flags look like
before they get folded into six.

## Maintaining it

`SKILL.md` ends with rules for its own upkeep, and `check.sh` enforces the
mechanical ones in CI. A new caught failure gets one line added to whichever
family already covers it. A genuinely new family is rare, since a new
incident is not the same thing as a new rationalization mechanism.

The budget is 16KB. Over budget means compress before adding.

## What it does not do

It cannot make an agent verify something it has no way to look up. Air-gapped
runs, private internal systems, and platforms with no public docs all fall
back to "state it as unverified," which is honest but not a check.

It also raises token cost on every session that loads it, and it makes the
agent slower and more annoying by design. An agent that stops to fetch docs
before answering is not the one that feels fastest.

## License

MIT. See [LICENSE](LICENSE).
