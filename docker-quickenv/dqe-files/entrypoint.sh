#!/bin/bash
# Docker QuickENV entrypoint script

for hook in "$DQE_ROOT"/hooks/[0-9]*.sh; do
  [ -f "$hook" ] && echo "$hook"
done