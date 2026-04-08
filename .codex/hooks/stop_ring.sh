#!/bin/sh

script_dir=$(CDPATH= cd -- "$(dirname "$0")" && pwd)
repo_root=$(CDPATH= cd -- "$script_dir/../.." && pwd)
log_file="$repo_root/.codex/hooks/stop_ring.log"

{
  printf '[%s] stop hook invoked cwd=%s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" "$PWD"
} >>"$log_file" 2>/dev/null || true

bash "$repo_root/ring.sh" >/dev/null 2>&1
rc=$?

{
  printf '[%s] ring.sh exit=%s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" "$rc"
} >>"$log_file" 2>/dev/null || true

exit 0
