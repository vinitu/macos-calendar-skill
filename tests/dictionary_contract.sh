#!/usr/bin/env bash
set -euo pipefail

tmp_calendar="$(mktemp)"
trap 'rm -f "$tmp_calendar"' EXIT

make --no-print-directory dictionary-calendar >"$tmp_calendar"

has_pattern() {
	local pattern="$1"
	local file="$2"
	if command -v rg >/dev/null 2>&1; then
		rg -q "$pattern" "$file"
	else
		grep -q -- "$pattern" "$file"
	fi
}

has_pattern '<class name="calendar"' "$tmp_calendar"
has_pattern '<class name="event"' "$tmp_calendar"
has_pattern '<command name="create"' "$tmp_calendar" || has_pattern 'create calendar' "$tmp_calendar"

printf 'dictionary_contract: ok\n'
