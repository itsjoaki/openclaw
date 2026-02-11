#!/bin/sh
set -e

# Create Git configuration symlinks (persist across container restarts)
if [ -f /data/.gitconfig ]; then
  ln -sf /data/.gitconfig /root/.gitconfig
fi

if [ -f /data/git-config/.git-credentials ]; then
  ln -sf /data/git-config/.git-credentials /root/.git-credentials
fi

# Fix volume permissions for node user (Railway mounts as root)
if [ -d /data ]; then
  chown -R node:node /data 2>/dev/null || true
fi

# Execute the main command (gateway runs as root on Fly.io)
exec "$@"
