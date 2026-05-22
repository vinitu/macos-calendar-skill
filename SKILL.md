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

- `scripts/commands/event/*`

## Commands

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

## Safety Boundaries

- Event delete and write actions must be explicit.
- Internal AppleScript files are not public API.
