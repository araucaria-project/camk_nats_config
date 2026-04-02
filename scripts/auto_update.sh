#!/bin/bash
# Auto-update for camk_nats_config
# Called by systemd timer every 5 minutes as poweruser

export HOME=/opt/poweruser
export PATH="/opt/poweruser/.local/bin:/usr/local/bin:/usr/bin"

REPO_DIR="/opt/poweruser/src/camk_nats_config"
cd "${REPO_DIR}"

OLD_HEAD=$(git rev-parse HEAD)

git fetch
git pull
echo "Pulled changes from git"

NEW_HEAD=$(git rev-parse HEAD)

if [ "$OLD_HEAD" != "$NEW_HEAD" ]; then
    poetry update
    poetry install
    poetry run build
    echo "Updated NATS streams"
fi
