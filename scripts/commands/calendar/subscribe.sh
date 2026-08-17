#!/usr/bin/env bash
# Output: JSON envelope {"success":true,"data":...} (see SKILL.md).
# Backend: scripts/applescripts/calendar/subscribe.applescript
# Example:
#   scripts/commands/calendar/subscribe.sh "webcal://example.com/calendar.ics"
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
require_arg "${1:-}" "iCalendar URL"
[[ $# -gt 1 ]] && usage "$(basename "$0") <url>"
run_backend calendar subscribe "$@"