---
name: macos-calendar
description: Create, read, update, and delete events in Apple Calendar.app on macOS. Use for scheduling, checking availability, managing recurring events, and setting reminders.
---

# macOS Calendar

Use this skill when the task is about Apple Calendar.app on macOS.

## Main Rule

Use only `scripts/commands`.
Do not call `scripts/applescripts` directly.

## Requirements

- macOS with Calendar.app
- Automation permissions for the terminal.

## Public Interface

Run commands from `scripts/commands`:

- `scripts/commands/calendar/*`
- `scripts/commands/event/*`

## Commands

### Calendar

```bash
scripts/commands/calendar/get.sh "Calendar Name"
scripts/commands/calendar/list.sh
scripts/commands/calendar/reload.sh "Calendar Name"
scripts/commands/calendar/subscribe.sh "https://example.com/calendar.ics"
scripts/commands/calendar/switch-view.sh "day"
scripts/commands/calendar/view-at.sh "2024-01-01"
```

### Event

```bash
scripts/commands/event/alert.sh
scripts/commands/event/create.sh
scripts/commands/event/delete.sh
scripts/commands/event/get.sh
scripts/commands/event/list-range.sh
scripts/commands/event/list.sh
scripts/commands/event/recurring.sh
scripts/commands/event/search-range.sh
scripts/commands/event/search.sh
scripts/commands/event/show.sh
scripts/commands/event/update.sh
```

## JSON Contract

Calendar object:

- `name` (string)
- `account` (string)

Event object:

- `summary` (string)
- `start_date` (string, ISO 8601)
- `end_date` (string, ISO 8601)
- `location` (string or null)
- `description` (string or null)
- `allday` (boolean)

Scalar envelopes:

- `success/failure`: `{"success": true/false, "error": "..."}`

## Safety Boundaries

- Event delete and write actions must be explicit.
- Internal AppleScript files are not public API.
