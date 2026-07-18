# bitch-stop-lyin

Your agent tells you to open Settings, then Integrations, then click Add Account. The menu says something else. That tab moved two releases ago, and you lose twenty minutes before working out that confident, specific, plausible instructions came from training data and were checked against nothing.

Hence the name.

Drop-in skill for [Claude Code](https://claude.com/claude-code). The ideas port to any harness that takes a system prompt.

## About the name

It's an Ice Cube line, from "Gangsta Gangsta" on N.W.A's *Straight Outta Compton*. Old heads will place it. WhoSampled has that track turning up in [over 200 songs](https://www.whosampled.com/N.W.A/Gangsta-Gangsta/sampled/).

The bitch in question is Claude. This thing exists because my agent kept telling me things it never checked, and the name is addressed to the machine doing the lying.

If that doesn't fly where you work, the directory name is the invocation name. Rename it to whatever passes review.

## Why "don't hallucinate" does nothing

The agent almost never decides to make something up. It reaches for a fact that feels solid, and the feeling of solidity is the entire problem. Familiar platforms are where training data rots fastest, because nothing ever gave you a reason to doubt something you've "known" for two years.

Telling a model not to hallucinate accomplishes nothing. Telling it to verify before claiming accomplishes a little. Naming the specific excuse it uses to skip the check works, because the excuse always arrives dressed as a reasonable thought.

## What it does

Two protocols, both firing on what the agent is about to output rather than on what you typed. That distinction does most of the work. A gate keyed to your input misses the claim the agent volunteers in a closing paragraph, and plenty of the bad ones live there.

**Protocol A** covers scope and estimates. Six steps, an explicit assumption ledger, three numbers instead of one. No point estimate survives while an assumption is still unverified.

**Protocol B** covers technical claims about named external systems. Every claim gets checked against current docs first. No exempt document types, no "I know this one" list, no home-turf exemption, so the agent verifies claims about its own product surface like anyone else's.

## The six rationalization families

The rules matter less than the taxonomy of excuses. Every verification skip this thing has caught reduces to one of six thoughts.

**1. No exempt frame.** "This is conversational." "It's a proposal, not a spec." "I'm only summarizing what we already established." "Nobody asked, I volunteered it." Position, register, document type, and authorship change nothing. Restating an unverified claim creates a fresh unverified claim.

**2. A hedge is a confession.** The moment you write "usually," or "(or similar)," or "click Export or maybe Download," you've admitted you're guessing. That admission is the cue to go check, not a license to publish with a softener attached. Two candidate names for one button means you never looked.

**3. Inference is not observation.** "The call failed, so the service is down." A mechanism you deduced from symptoms is a hypothesis wearing a fact's clothing. Trace the code path, or write "Hypothesis, unverified" and keep moving.

**4. Familiarity is the alarm, not the clearance.** The platforms you know best hold your stalest information and are the ones you'll never think to check. Pricing and compliance policies change quietly and feel permanent.

**5. Borrowed verification isn't yours.** A subagent came back with citations, so the claim feels checked. It isn't. Two correctly-cited numbers combined into a comparison produce a third claim nobody verified, resting on units nobody confirmed were comparable.

**6. No number without a source.** A statistic that happens to support your argument is evidence you built it. Cite it or cut it.

Naming the families is what makes this work on smaller models. Thirty-four individual war stories aren't retrievable mid-response. Six named patterns are.

## Install

```bash
git clone https://github.com/jared-the-automator/bitch-stop-lyin.git
cp -r bitch-stop-lyin ~/.claude/skills/
```

No dependencies, no configuration.

For other harnesses, paste `SKILL.md` into your system prompt or rules file. [docs/ADAPTING.md](docs/ADAPTING.md) covers Cursor, Copilot, and raw API use, including what to cut first when you need it smaller.

## The compression story

This file hit 33KB. That's about 8,000 tokens on every single load. Each caught failure had been appended as a fresh red flag carrying the full narrative of the incident behind it, fifteen rounds of that, and five of the flags restated entire sections already sitting elsewhere in the same document.

Compressing to 15KB cut the per-load cost by 54% and lost no rules, which I verified by probing the new text for all 42 distinct concepts in the old one.

The lesson runs against instinct. A behavioral skill that grows by appending one story per incident decays into something too long to follow, and the decay is invisible because every individual addition looks justified at the time. Fold new failures into families that already exist. Put the story in the commit message.

`archive/2026-07-14-pre-compression.md` holds the original text. Read it next to `SKILL.md` if you want to see what 34 narrative red flags look like before they get folded into six.

## Maintaining it

`SKILL.md` ends with rules for its own upkeep, and `check.sh` enforces the mechanical ones in CI: a 16KB budget, the required sections, exactly six families, and no family entry over 1200 characters. That last check is the one that catches somebody pasting an incident narrative back in.

A new caught failure gets one line added to whichever family already covers it. New families are rare, since a new incident isn't the same thing as a new rationalization mechanism.

## What it doesn't do

It can't make an agent verify something it has no way to look up. Air-gapped runs, private internal systems, and platforms without public docs all fall back to "state it as unverified," which is honest and isn't a check.

It raises token cost on every session that loads it. It also makes the agent slower and more annoying on purpose, because an agent that stops to fetch docs before answering will never be the one that feels fastest.

## License

MIT. See [LICENSE](LICENSE).
