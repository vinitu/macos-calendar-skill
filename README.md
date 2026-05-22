# macOS Calendar Skill

This repo stores an AI agent skill for Apple Calendar.app on macOS.

The public interface is `scripts/commands`.
`scripts/applescripts` stores internal AppleScript backends and dictionary-aligned coverage.

## Installation

```bash
npx skills add vinitu/macos-calendar-skill
```

Or with [skills.sh](https://skills.sh):

```bash
skills.sh add vinitu/macos-calendar-skill
```

## Prerequisites

- macOS with Calendar.app
- Automation permission granted to your terminal app

## Public Interface

Run skill actions with:

```bash
scripts/commands/<entity>/<action>.sh [args...]
```

## Backend Map

- `scripts/commands/calendar/*` → AppleScript in `scripts/applescripts/calendar/*`
- `scripts/commands/event/*` → AppleScript in `scripts/applescripts/event/*`

## Command Surface

Calendar:

- `scripts/commands/calendar/get.sh`
- `scripts/commands/calendar/list.sh`
- `scripts/commands/calendar/reload.sh`
- `scripts/commands/calendar/subscribe.sh`
- `scripts/commands/calendar/switch-view.sh`
- `scripts/commands/calendar/view-at.sh`

Event:

- `scripts/commands/event/alert.sh`
- `scripts/commands/event/create.sh`
- `scripts/commands/event/delete.sh`
- `scripts/commands/event/get.sh`
- `scripts/commands/event/list-range.sh`
- `scripts/commands/event/list.sh`
- `scripts/commands/event/recurring.sh`
- `scripts/commands/event/search-range.sh`
- `scripts/commands/event/search.sh`
- `scripts/commands/event/show.sh`
- `scripts/commands/event/update.sh`

## Validation

```bash
make compile
make test
```
