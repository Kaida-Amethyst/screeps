#!/bin/sh

script_dir=$(CDPATH= cd -- "$(dirname "$0")" && pwd)
repo_root=$(CDPATH= cd -- "$script_dir/../.." && pwd)

bash "$repo_root/ring.sh" >/dev/null 2>&1 || true
exit 0
