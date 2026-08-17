#!/usr/bin/env bash
# Output: JSON envelope {"success":true,"data":...} (see SKILL.md).
# Backend: scripts/applescripts/calendar/switch-view.applescript
# Example:
#   scripts/commands/calendar/switch-view.sh "day view"
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
require_arg "${1:-}" "view type"
[[ $# -gt 1 ]] && usage "$(basename "$0") <day view|week view|month view>"
run_backend calendar switch-view "$@"