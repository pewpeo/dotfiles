#!/usr/bin/env bash

# Fetch all local branches from origin
for branch in $(git branch --format='%(refname:short)'); do
  git fetch origin "$branch"
done
