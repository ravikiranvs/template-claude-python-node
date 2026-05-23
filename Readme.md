# Claude Code Devcontainer Template

A ready-to-use devcontainer for AI-assisted development with Claude Code, Playwright CLI, and a curated set of engineering skills. Open any repo with this template and your AI workflow is pre-configured.

## What's included

- **Ubuntu devcontainer** with Node 22, ripgrep, jq, tree, and the GitHub CLI
- **Claude Code** pre-installed and configured
- **`playwright-cli`** for token-efficient browser automation with AI agents
- **Claude Code skills** from [mattpocock/skills](https://github.com/mattpocock/skills): `setup-matt-pocock-skills`, `grill-with-docs`, `to-prd`, `to-issues`, `tdd`
- **Persistent volumes** for Claude config and skills — survive container rebuilds
- **`CLAUDE.md`** at the repo root — Claude Code reads this every session for project context

---

## Prerequisites

Before you start, make sure you have the following installed and configured on your machine.

**Docker Desktop**
Required to build and run the devcontainer.
https://www.docker.com/products/docker-desktop

On Windows, enable the WSL 2 backend in Docker Desktop settings.

**VS Code**
https://code.visualstudio.com

**Dev Containers extension for VS Code**
Install from the VS Code marketplace, or run:
```bash
code --install-extension ms-vscode-remote.remote-containers
```

**Claude Code authentication**
You need a Claude account and an active Claude Code session. If you haven't authenticated yet, run `claude` in a terminal and follow the login prompt before opening the devcontainer.

**GitHub CLI authentication (optional)**
Required if you want `to-prd` and `to-issues` to create GitHub issues automatically. Authenticate on your host machine before opening the container:
```bash
gh auth login
```
The container inherits your `gh` credentials via the devcontainer.

---

## Usage

### 1. Create your repo from this template

Click **Use this template** at the top of this page and create a new repository.

### 2. Clone your new repo and open it in VS Code

```bash
git clone https://github.com/your-username/your-repo
code your-repo
```

### 3. Reopen in container

VS Code will detect the `.devcontainer` folder and prompt you:

> Reopen in Container

Click it. If the prompt doesn't appear, open the command palette (`Ctrl+Shift+P` / `Cmd+Shift+P`) and run:

> Dev Containers: Reopen in Container

The first build takes a few minutes. Subsequent opens are fast.

### 4. Run first-time setup

Once the container is ready, open Claude Code and run:

```
/setup-matt-pocock-skills
```

This configures the engineering skills for your repo — issue tracker, triage labels, and domain doc layout. Run it once per repo. All other skills depend on it.

---

## Workflow

Use these slash commands in Claude Code for a structured feature development loop:

| Step | Command | What it does |
|---|---|---|
| 1 | `/grill-with-docs` | Stress-tests your plan against the existing domain model and docs |
| 2 | `/to-prd` | Synthesizes the conversation into a PRD, filed as a GitHub issue |
| 3 | `/to-issues` | Breaks the PRD into vertical-slice GitHub issues |
| 4 | `/tdd` | Implements each issue with red-green-refactor, one slice at a time |

---

## Project structure

```
your-repo/
├── .devcontainer/
│   ├── devcontainer.json       # Container config, mounts, extensions
│   ├── Dockerfile              # Ubuntu + Node 22 + gh + playwright-cli
│   └── postCreateCommand.sh    # Runs once after container is created
└── CLAUDE.md                   # Project instructions read by Claude Code
```

---

## Customising for your project

**Add your own conventions to `CLAUDE.md`**
The `## Code conventions` section is intentionally minimal. Add anything Claude Code should know about your stack, folder structure, naming conventions, or preferred libraries.

**Add VS Code extensions**
Add extension IDs to the `extensions` array in `.devcontainer/devcontainer.json`.

**Add project dependencies**
Uncomment and adapt the example blocks at the bottom of `postCreateCommand.sh`:
```bash
echo "[postCreate] Installing dependencies..."
npm ci
```

**Add more skills**
Browse [skills.sh](https://www.skills.sh) or [github.com/mattpocock/skills](https://github.com/mattpocock/skills) and add `--skill` flags to the `npx skills add` call in `postCreateCommand.sh`.