#!/usr/bin/env bash
# Output: JSON envelope {"success":true,"data":...} (see SKILL.md).
# Backend: scripts/applescripts/calendar/view-at.applescript
# Example:
#   scripts/commands/calendar/view-at.sh "2026-03-15"
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
require_arg "${1:-}" "date"
[[ $# -gt 1 ]] && usage "$(basename "$0") <date>"
run_backend calendar view-at "$@"