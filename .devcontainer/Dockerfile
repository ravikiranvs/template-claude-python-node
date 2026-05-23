# Base image – Microsoft's base devcontainer image (git, curl, zsh, vscode user).
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# ── System packages ───────────────────────────────────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
      ripgrep \
      jq \
      tree \
      ca-certificates \
      gnupg \
      python3 \
      python3-pip \
      python3-venv \
    && rm -rf /var/lib/apt/lists/*

# ── Node 22 via NodeSource ────────────────────────────────────────────────────
# devcontainers/base does NOT ship nvm; install Node system-wide via NodeSource.
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# ── GitHub CLI ────────────────────────────────────────────────────────────────
# Required by to-prd and to-issues skills to create GitHub issues via `gh issue create`.
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
      | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
      > /etc/apt/sources.list.d/github-cli.list \
    && apt-get update \
    && apt-get install -y gh \
    && rm -rf /var/lib/apt/lists/*

# ── Claude Code & Playwright CLI ─────────────────────────────────────────────
# The devcontainer feature (in devcontainer.json) will also install Claude Code,
# but installing it here too lets us pin a version and disable auto-update.
ARG CLAUDE_VERSION=latest
RUN npm install -g \
      @anthropic-ai/claude-code@${CLAUDE_VERSION} \
      @playwright/cli@latest

# ── Global Claude settings (managed policy) ───────────────────────────────────
# Anything in /etc/claude-code/managed-settings.json is applied at the
# highest precedence and cannot be overridden by per-project settings.
# Uncomment and edit to enforce organization policy.
# RUN mkdir -p /etc/claude-code
# COPY managed-settings.json /etc/claude-code/managed-settings.json

WORKDIR /workspace