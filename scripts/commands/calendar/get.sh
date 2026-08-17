#!/usr/bin/env bash
# Output: JSON envelope {"success":true,"data":...} (see SKILL.md).
# Backend: scripts/applescripts/calendar/get.applescript
# Example:
#   scripts/commands/calendar/get.sh "Home"
#   scripts/commands/calendar/get.sh "Home" color
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
require_arg "${1:-}" "calendar name"
[[ $# -gt 2 ]] && usage "$(basename "$0") <calendar-name> [property]"
run_backend calendar get "$@"