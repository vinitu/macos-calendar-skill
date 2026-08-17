#!/usr/bin/env bash
# Output: JSON envelope {"success":true,"data":...} (see SKILL.md).
# Backend: scripts/applescripts/calendar/reload.applescript
# Example:
#   scripts/commands/calendar/reload.sh "Home"
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
require_arg "${1:-}" "calendar name"
[[ $# -gt 1 ]] && usage "$(basename "$0") <calendar-name>"
run_backend calendar reload "$@"