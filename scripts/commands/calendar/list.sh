#!/usr/bin/env bash
# Output: JSON envelope {"success":true,"data":...} (see SKILL.md).
# Backend: scripts/applescripts/calendar/list.applescript
# Example:
#   {"success":true,"data":"Home (iCloud)\nWork (iCloud)\n"}
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
[[ $# -gt 0 ]] && usage "$(basename "$0")"
run_backend calendar list "$@"