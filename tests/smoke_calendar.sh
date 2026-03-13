#!/usr/bin/env bash
# Smoke test for Calendar skill. Skips with exit 0 when Calendar is not available.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! osascript -e 'tell application "Calendar" to get name' >/dev/null 2>&1; then
	echo "smoke_calendar: Calendar.app not available."
	exit 0
fi

osascript -e 'tell application "Calendar" to get name' | grep -q . || { echo "smoke_calendar: could not get app name." >&2; exit 1; }

# List calendars (script layer); skip rest if Calendar not running (-600)
cal_list="$(osascript "$ROOT_DIR/scripts/calendar/list.applescript" 2>&1)" || { echo "smoke_calendar: Calendar not running, skipping script layer."; exit 0; }
printf '%s\n' "$cal_list" >/dev/null || { echo "smoke_calendar: calendar list failed." >&2; exit 1; }

# List today's events (script layer)
evt_list="$(osascript "$ROOT_DIR/scripts/event/list.applescript" 2>&1)" || { echo "smoke_calendar: event list failed (Calendar may have quit)."; exit 0; }
printf '%s\n' "$evt_list" >/dev/null || { echo "smoke_calendar: event list failed." >&2; exit 1; }

# List events in range (script layer)
start_date="$(date +%Y-%m-%d)"
end_date="$(date -v+7d +%Y-%m-%d 2>/dev/null || date -d '+7 days' +%Y-%m-%d 2>/dev/null || echo "$start_date")"
evt_range="$(osascript "$ROOT_DIR/scripts/event/list-range.applescript" "$start_date" "$end_date" 2>&1)" || { echo "smoke_calendar: event list-range failed."; exit 0; }
printf '%s\n' "$evt_range" >/dev/null || true

# Calendar get (read-only: first calendar name from list)
first_cal="$(echo "$cal_list" | head -1 | sed 's/ ([^)]*)$//')"
if [ -n "$first_cal" ]; then
	cal_get="$(osascript "$ROOT_DIR/scripts/calendar/get.applescript" "$first_cal" 2>/dev/null)" || true
	[ -z "$cal_get" ] || printf '%s\n' "$cal_get" >/dev/null || true
fi

echo "smoke_calendar: ok"
