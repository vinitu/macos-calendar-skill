# macOS Calendar Skill

This repo stores a skill for macOS Calendar.app integration via AppleScript.

## Installation

```bash
npx skills add vinitu/macos-calendar-skill
```

Or with [skills.sh](https://skills.sh):

```bash
skills.sh add vinitu/macos-calendar-skill
```

## Scope

- List all calendars and their accounts.
- Create, read, update, and delete events.
- Search events by title and date range.
- Create recurring events (daily, weekly, monthly).
- Set display alerts/reminders on events.

## Prerequisites

- macOS with Calendar.app configured
- At least one calendar account (iCloud, Google, Exchange, etc.)
- Automation permission granted to terminal (System Settings → Privacy & Security → Automation)

## How To Use

From the skill directory (or path where scripts are installed):

```bash
# List all calendars with account name
osascript scripts/calendar/list.applescript
# Create event in calendar "Home" (summary, start, end)
osascript scripts/event/create.applescript "Home" "Dentist" "2026-03-15 10:00:00" "2026-03-15 11:00:00"
# List events in date range (start, end)
osascript scripts/event/list-range.applescript "2026-03-15 00:00:00" "2026-03-16 00:00:00"
# Delete events with given summary in calendar
osascript scripts/event/delete.applescript "Home" "Dentist"
```

For the full command set and examples, see `SKILL.md` and scripts under `scripts/`.

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "not authorized" error | Grant Automation permission to terminal in System Settings |
| Calendar not found | List calendars first to get exact names |
| Date parse error | Check system locale; try `"March 15, 2026 10:00:00 AM"` format |
| Event not syncing | Open Calendar.app and verify the account is online |
