#!/bin/bash
# =============================================================================
# postCreateCommand — runs once after the dev container is created.
# Reference: https://containers.dev/implementors/json_reference/#lifecycle-scripts
#
# Purpose: Set up the Claude environment inside the container.
# =============================================================================
set -euo pipefail

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------
VSCODE_USER="vscode"
CLAUDE_DIR="/home/${VSCODE_USER}/.claude"
GLOBAL_SKILLS_DIR="/home/${VSCODE_USER}/.claude-global-skills"
SKILLS_DIR="${CLAUDE_DIR}/skills"

# -----------------------------------------------------------------------------
# Claude — fix ownership & link global skills
#
# The .claude and .claude-global-skills directories are typically mounted from
# the host (via devcontainer mounts), so ownership may default to root.
# Resetting ownership lets the vscode user read/write Claude config freely.
# -----------------------------------------------------------------------------
echo "[postCreate] Fixing ownership on Claude directories..."
sudo chown -R "${VSCODE_USER}:${VSCODE_USER}" "${CLAUDE_DIR}" "${GLOBAL_SKILLS_DIR}"

echo "[postCreate] Creating Claude skills directory..."
mkdir -p "${SKILLS_DIR}"

echo "[postCreate] Linking global skills into Claude skills directory..."
ln -sfn "${GLOBAL_SKILLS_DIR}" "${SKILLS_DIR}/global"

# -----------------------------------------------------------------------------
# Playwright CLI — install skills for Claude Code
#
# The CLI binary is installed in the Dockerfile (npm install -g @playwright/cli).
# Here we install the skill files into the Claude skills directory so Claude
# Code can discover and use them via the global skills symlink.
# -----------------------------------------------------------------------------
echo "[postCreate] Installing Playwright CLI skills..."
playwright-cli install --skills

# -----------------------------------------------------------------------------
# Matt Pocock skills — install selected engineering skills for Claude Code
#
# Installs only the skills used in this workflow:
#   setup-matt-pocock-skills  — one-time per-repo config (run this first)
#   grill-with-docs           — stress-test plans against domain model
#   to-prd                    — synthesize conversation into a GitHub PRD issue
#   to-issues                 — break PRD into vertical-slice GitHub issues
#   tdd                       — red-green-refactor, one vertical slice at a time
# -----------------------------------------------------------------------------
echo "[postCreate] Installing mattpocock/skills..."
npx skills add https://github.com/mattpocock/skills \
  --skill setup-matt-pocock-skills \
  --skill grill-with-docs \
  --skill to-prd \
  --skill to-issues \
  --skill tdd \
  --agent claude-code \
  --yes

# -----------------------------------------------------------------------------
# Add further setup steps below, e.g.:
#
#   echo "[postCreate] Installing dependencies..."
#   npm ci
#
#   echo "[postCreate] Setting up Python environment..."
#   pip install -r requirements.txt --break-system-packages
# -----------------------------------------------------------------------------

echo "[postCreate] Done."
echo ""
echo "┌─────────────────────────────────────────────────────────┐"
echo "│  First time using this repo?                            │"
echo "│  Open Claude Code and run: /setup-matt-pocock-skills    │"
echo "└─────────────────────────────────────────────────────────┘"