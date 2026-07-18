# Adapting to other harnesses

`SKILL.md` is plain markdown with a small YAML header. Nothing in it depends
on Claude Code beyond that header, so it moves anywhere that accepts
instructions.

## Claude Code

Copy the directory into `~/.claude/skills/`. The directory name becomes the
invocation name. Claude loads it when the description matches the task, and
you can invoke it directly.

To make it fire more reliably, add a line to your `CLAUDE.md` naming the
trigger conditions, since a skill that loads only on model judgment will
sometimes not load at the moment you needed it most.

## Cursor

Paste the body of `SKILL.md` into `.cursorrules`, or into a file under
`.cursor/rules/` on newer versions. Drop the YAML header, since Cursor does
not read it.

Cursor rules load on every request, so the 15KB matters more here than in a
skill system that loads on demand. Consider trimming Protocol A if you only
want the technical-claims half.

## GitHub Copilot

Put the body in `.github/copilot-instructions.md`. Same advice about dropping
the header and watching the size.

## Raw API / your own agent loop

Append the body to your system prompt. Two adjustments earn their keep:

Replace the tool names in the Verification Tool Order section with whatever
your agent actually has. The section names a docs tool, a fetch tool, and a
search tool in priority order, and the names matter less than the order.

Consider running the pre-send scan as a separate cheap model call rather than
trusting the same model that wrote the text to audit it. Asking a model to
re-read its own output for unverified claims works better when the reader is
a fresh context with one job.

## What to cut if you need it smaller

Roughly, by value per byte:

Keep the six rationalization families and the Protocol B trigger definition.
That is the core, about 4KB, and it does most of the work.

The Claim Categories section is next. It is mechanical and specific, so it
transfers well, but each bullet only pays off if you work with that category
of system.

Protocol A is separable. Cut it entirely if estimates are not part of what
your agent produces.

The Maintaining This Skill section is for whoever edits the file later. It
costs tokens at runtime and buys nothing during a session. Strip it if you
are pasting into a system prompt and keep it in your source copy.

## A note on strictness

The skill is written in absolute terms on purpose. Hedged instructions get
hedged compliance, and every softener you add becomes an exemption the model
finds later. If it proves too strict for your work, cut whole sections rather
than weakening the language in the sections you keep.
