---
name: macos-calendar
description: Create, read, update, and delete events in Apple Calendar.app on macOS. Use for scheduling, checking availability, managing recurring events, and setting reminders. Triggers on queries about calendar, events, meetings, scheduling, or appointments.
---

# macOS Calendar Integration

Manage events in Calendar.app using AppleScript (`osascript`) on macOS.

## Prerequisites

- macOS with Calendar.app configured
- At least one calendar account set up (iCloud, Google, Exchange, etc.)
- Automation permission granted to your terminal (System Settings → Privacy & Security → Automation)

## Listing Calendars

```bash
osascript -e '
tell application "Calendar"
  set output to ""
  repeat with c in calendars
    set output to output & name of c & " (" & name of (account of c) & ")" & linefeed
  end repeat
  return output
end tell'
```

## Creating Events

### Simple event

```bash
osascript -e '
tell application "Calendar"
  tell calendar "Home"
    make new event with properties {summary:"Dentist", start date:date "2026-03-15 10:00:00", end date:date "2026-03-15 11:00:00"}
  end tell
end tell'
```

### Event with location and notes

```bash
osascript -e '
tell application "Calendar"
  tell calendar "Home"
    make new event with properties {summary:"Lunch with Alex", start date:date "2026-03-16 12:30:00", end date:date "2026-03-16 13:30:00", location:"Rynek 1, Wrocław", description:"Discuss project roadmap"}
  end tell
end tell'
```

### All-day event

```bash
osascript -e '
tell application "Calendar"
  tell calendar "Home"
    make new event with properties {summary:"Team offsite", start date:date "2026-04-01 00:00:00", end date:date "2026-04-02 00:00:00", allday event:true}
  end tell
end tell'
```

## Reading Events

### Events in a date range

```bash
osascript -e '
set startDate to current date
set hours of startDate to 0
set minutes of startDate to 0
set seconds of startDate to 0
set endDate to startDate + 7 * days

tell application "Calendar"
  set output to ""
  repeat with c in calendars
    set evts to (every event of c whose start date ≥ startDate and start date ≤ endDate)
    repeat with e in evts
      set output to output & (start date of e) & " | " & summary of e & " | " & name of c & linefeed
    end repeat
  end repeat
  return output
end tell'
```

### Today's events

```bash
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
      set output to output & (start date of e) & " - " & (end date of e) & " | " & summary of e & linefeed
    end repeat
  end repeat
  return output
end tell'
```

### Get event details

```bash
osascript -e '
tell application "Calendar"
  tell calendar "Home"
    set evts to (every event whose summary is "Dentist")
    repeat with e in evts
      set output to "Summary: " & summary of e & linefeed
      set output to output & "Start: " & (start date of e) & linefeed
      set output to output & "End: " & (end date of e) & linefeed
      set output to output & "Location: " & location of e & linefeed
      set output to output & "Notes: " & description of e & linefeed
      set output to output & "All-day: " & allday event of e & linefeed
      return output
    end repeat
  end tell
end tell'
```

## Updating Events

### Change event time

```bash
osascript -e '
tell application "Calendar"
  tell calendar "Home"
    set evts to (every event whose summary is "Dentist")
    repeat with e in evts
      set start date of e to date "2026-03-15 14:00:00"
      set end date of e to date "2026-03-15 15:00:00"
    end repeat
  end tell
end tell'
```

### Change event title

```bash
osascript -e '
tell application "Calendar"
  tell calendar "Home"
    set evts to (every event whose summary is "Dentist")
    repeat with e in evts
      set summary of e to "Dentist (rescheduled)"
    end repeat
  end tell
end tell'
```

## Deleting Events

```bash
osascript -e '
tell application "Calendar"
  tell calendar "Home"
    set evts to (every event whose summary is "Dentist (rescheduled)")
    repeat with e in evts
      delete e
    end repeat
  end tell
end tell'
```

## Searching Events

### Search by title across all calendars

```bash
osascript -e '
tell application "Calendar"
  set output to ""
  repeat with c in calendars
    set evts to (every event of c whose summary contains "meeting")
    repeat with e in evts
      set output to output & (start date of e) & " | " & summary of e & " | " & name of c & linefeed
    end repeat
  end repeat
  return output
end tell'
```

### Search within a specific date range

```bash
osascript -e '
set rangeStart to date "2026-03-01 00:00:00"
set rangeEnd to date "2026-03-31 23:59:59"

tell application "Calendar"
  set output to ""
  repeat with c in calendars
    set evts to (every event of c whose start date ≥ rangeStart and start date ≤ rangeEnd and summary contains "standup")
    repeat with e in evts
      set output to output & (start date of e) & " | " & summary of e & linefeed
    end repeat
  end repeat
  return output
end tell'
```

## Recurring Events

### Weekly recurring event

```bash
osascript -e '
tell application "Calendar"
  tell calendar "Work"
    set newEvent to make new event with properties {summary:"Weekly standup", start date:date "2026-03-16 09:00:00", end date:date "2026-03-16 09:30:00"}
    set recStr to "FREQ=WEEKLY;BYDAY=MO;COUNT=12"
    set recurrence of newEvent to recStr
  end tell
end tell'
```

### Daily recurring event

```bash
osascript -e '
tell application "Calendar"
  tell calendar "Home"
    set newEvent to make new event with properties {summary:"Morning run", start date:date "2026-03-16 07:00:00", end date:date "2026-03-16 07:45:00"}
    set recurrence of newEvent to "FREQ=DAILY;COUNT=30"
  end tell
end tell'
```

### Monthly recurring event

```bash
osascript -e '
tell application "Calendar"
  tell calendar "Home"
    set newEvent to make new event with properties {summary:"Rent payment", start date:date "2026-04-01 00:00:00", end date:date "2026-04-02 00:00:00", allday event:true}
    set recurrence of newEvent to "FREQ=MONTHLY;BYMONTHDAY=1;COUNT=12"
  end tell
end tell'
```

## Setting Reminders / Alerts

### Alert before event

```bash
osascript -e '
tell application "Calendar"
  tell calendar "Home"
    set newEvent to make new event with properties {summary:"Flight to Berlin", start date:date "2026-04-10 06:00:00", end date:date "2026-04-10 08:30:00"}
    -- alert 60 minutes before
    make new display alarm at end of display alarms of newEvent with properties {trigger interval:-60}
  end tell
end tell'
```

### Multiple alerts

```bash
osascript -e '
tell application "Calendar"
  tell calendar "Home"
    set newEvent to make new event with properties {summary:"Important meeting", start date:date "2026-04-15 14:00:00", end date:date "2026-04-15 15:00:00"}
    -- alert 1 day before
    make new display alarm at end of display alarms of newEvent with properties {trigger interval:-1440}
    -- alert 30 minutes before
    make new display alarm at end of display alarms of newEvent with properties {trigger interval:-30}
  end tell
end tell'
```

## Best Practices

### Calendar Selection
- Always specify which calendar to operate on by name.
- List calendars first if you are unsure of the exact name.

### Date Formats
- AppleScript parses dates using the system locale. The format `"YYYY-MM-DD HH:MM:SS"` works with most macOS locale settings.
- For locale-independent dates, construct them programmatically with `current date` and arithmetic.

### Performance
- Searching across all calendars with large histories can be slow. Narrow the date range whenever possible.
- Use `whose` filters in the AppleScript query instead of filtering in a loop.

### Safety
- **Never delete events without explicit user confirmation.**
- When updating recurring events, be aware that changes may affect all occurrences.
- Calendar changes sync to cloud accounts — they are not local-only.

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "not authorized" error | Grant Automation permission to terminal in System Settings |
| Calendar not found | Run the list-calendars command to get exact names |
| Date parse error | Check system locale; try `"March 15, 2026 10:00:00 AM"` format |
| Event not syncing | Open Calendar.app and verify the account is online |
| Recurrence not applied | Ensure the recurrence string follows RFC 5545 RRULE syntax |
