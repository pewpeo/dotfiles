#!/usr/bin/env bash

# remove all remote refs on origin except for main
for ref in $(git for-each-ref --format='%(refname)' refs/remotes/origin/); do
  if [[ "$ref" != "refs/remotes/origin/main" ]]; then
    git update-ref -d "$ref"
  fi
done
