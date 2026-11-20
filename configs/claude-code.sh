#!/usr/bin/env bash
set -euo pipefail

# Generate your personal token at https://earlylore.com/account (starts with el_live_)
claude mcp add --transport http earlylore https://earlylore.com/api/mcp \
  --header "Authorization: Bearer el_live_YOUR_TOKEN"
