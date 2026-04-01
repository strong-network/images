#!/bin/bash
# Strong Network startup script — runs at container start after /home/developer is mounted

# Install Claude Code from cached binary (offline, first run only)
if [ ! -x "$HOME/.local/bin/claude" ]; then
  echo "Setting up Claude Code for the first time (this only happens once)..."
  /opt/claude-installer/claude install
fi
