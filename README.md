# macOS Calendar Skill

This repo stores a skill for macOS Calendar.app integration via AppleScript.

## Installation

Install with `skills.sh`:

```bash
skills.sh add vinitu/macos-calendar-skill
```

If you use the npm installer instead:

```bash
npx skills add vinitu/macos-calendar-skill
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

```bash
# List all calendars
osascript -e 'tell application "Calendar" to return name of every calendar'

# Create an event
osascript -e '
tell application "Calendar"
  tell calendar "Home"
    make new event with properties {summary:"Dentist", start date:date "2026-03-15 10:00:00", end date:date "2026-03-15 11:00:00"}
  end tell
end tell'

# Get today's events
osascript -e '
set todayStart to current date
set hours of todayStart to 0
set minutes of todayStart to 0
set seconds of todayStart to 0
set todayEnd to todayStart + 1 * days
tell application "Calendar"
  set output to ""
  repeat with c in calendars
    set evts to (every event of c whose start date ≥ todayStart and start date < todayEnd)
    repeat with e in evts
      set output to output & (start date of e) & " | " & summary of e & linefeed
    end repeat
  end repeat
  return output
end tell'

# Delete an event
osascript -e '
tell application "Calendar"
  tell calendar "Home"
    delete (every event whose summary is "Dentist")
  end tell
end tell'
```

For the full command set and examples, see `SKILL.md`.

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "not authorized" error | Grant Automation permission to terminal in System Settings |
| Calendar not found | List calendars first to get exact names |
| Date parse error | Check system locale; try `"March 15, 2026 10:00:00 AM"` format |
| Event not syncing | Open Calendar.app and verify the account is online |
