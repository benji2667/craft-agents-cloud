#!/bin/bash
set -e

# Railway mounts volumes owned by root. Fix ownership so craftagents can write,
# then drop privileges before exec — Claude Code refuses --dangerously-skip-permissions
# when running as root/sudo.
chown -R craftagents:craftagents /home/craftagents/.craft-agent 2>/dev/null || true

exec gosu craftagents bun run /app/packages/server/src/index.ts --allow-insecure-bind
