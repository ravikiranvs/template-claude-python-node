# Claude Code — Project Instructions

## Environment

- **Container:** Ubuntu (mcr.microsoft.com/devcontainers/base:ubuntu)
- **Node:** 22 (installed system-wide via NodeSource)
- **Shell:** bash (`/bin/bash`)
- **Working directory:** `/workspace` (project source code lives here)
- **User:** `vscode` (non-root; use `sudo` for system-level commands)

## Python

- Use `python3` — the `python` alias is not available
- Use `pip3 install --break-system-packages` for system-level installs
- For project dependencies, prefer a virtual environment:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### Available CLI tools

| Tool | Purpose |
|---|---|
| `playwright-cli` | Browser automation and e2e testing (see below) |
| `npx` | Run Node packages without global install |
| `rg` | ripgrep — fast file search, prefer over `grep` |
| `jq` | JSON querying and formatting |
| `tree` | Directory structure overview |
| `git` | Version control |
| `gh` | GitHub CLI (if authenticated) |

---

## Browser automation

Use `playwright-cli` for all browser automation, e2e testing, and UI interaction tasks.

- Do **not** use `@playwright/test` unless explicitly asked
- Run `playwright-cli --help` to discover available commands
- Skills for `playwright-cli` are pre-installed — check `~/.claude/skills/` for reference docs

```bash
# Open a browser session
playwright-cli open https://example.com

# Take a screenshot
playwright-cli screenshot https://example.com screenshot.png

# Run in headed mode (visible browser)
playwright-cli open https://example.com --headed
```

---

## Skills — workflow order for new features

Agent skills (slash commands) are pre-installed and available globally.
Run the skill name as a slash command in Claude Code, e.g. `/grill-with-docs`.

1. `/grill-with-docs` — stress-test the plan against existing domain model and docs
2. `/to-prd` — synthesize the conversation into a PRD, filed as a GitHub issue
3. `/to-issues` — break the PRD into vertical-slice GitHub issues (HITL and AFK)
4. `/tdd` — implement each issue with red-green-refactor, one vertical slice at a time

---

## Code conventions

- Prefer **vertical slices** over horizontal layers — each change should be end-to-end
- Tests verify **behaviour through public interfaces**, not implementation details
- Do not mock internal collaborators; write integration-style tests
- Commit frequently with descriptive messages after each green test

---
