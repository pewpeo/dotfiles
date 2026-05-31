#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_DIR"/.env

# init backup:
# - create passphrase:
#   (umask 0077; head -c 32 /dev/urandom | base64 -w 0 > ~/.borg-passphrase)
# - init borg repositry, remeber to save the passphrase also somewhere else:
#   export BORG_PASSCOMMAND="cat $HOME/.borg-passphrase"
#   borg init --encryption=repokey "/mnt/backup/immich-borg"

export BORG_PASSCOMMAND="cat $HOME/.borg-passphrase"

BACKUP_PATH="/mnt/backup/immich-borg"

borg create --progress "$BACKUP_PATH::{now:%Y-%m-%d_%H-%M-%S}" "$UPLOAD_LOCATION" --exclude "$UPLOAD_LOCATION"/thumbs/ --exclude "$UPLOAD_LOCATION"/encoded-video/
borg prune --keep-weekly=4 --keep-monthly=3 "$BACKUP_PATH"
borg compact "$BACKUP_PATH"

# restore with:
# borg mount "/mnt/backup/immich-borg /tmp/immich-mountpoint
# cd into specific backup directory
# rsync -a --delete library ~/immich
