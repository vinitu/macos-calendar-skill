# Repo Guide

This repo stores a skill for macOS Calendar.app integration.

## Public interface and internal backend

- `scripts/commands/` is the only public command surface. Run commands from the repo root with paths like `scripts/commands/<entity>/<action>.sh`.
- `scripts/applescripts/` is the internal backend. Do not call AppleScript files directly from skill instructions.
- Only commands listed in `SKILL.md` are public. Other scripts may exist for internal use or legacy cleanup.

## Goal

- Document AppleScript commands for Calendar.app accurately.
- Prefer runnable examples over long prose.
- Never delete or modify calendar events without explicit user approval.

## Repo Layout

- `AGENTS.md`: this file; rules for coding agents.
- `SKILL.md`: the skill contract and usage instructions for agents.
- `README.md`: public project overview and installation notes.
- `Makefile`: targets `dictionary-calendar`, `check`, `compile`, `test` (test-dictionary + test-smoke).
- `scripts/applescripts/calendar/list.applescript`: list calendar names with account names.
- `scripts/applescripts/calendar/get.applescript`: calendar properties (color, calendarIdentifier, writable, description).
- `scripts/applescripts/calendar/reload.applescript`, `switch-view.applescript`, `view-at.applescript`, `subscribe.applescript`.
- `scripts/applescripts/event/list.applescript`: list today's events across all calendars.
- `scripts/applescripts/event/list-range.applescript`, `get.applescript`, `create.applescript`, `update.applescript`, `delete.applescript`.
- `scripts/applescripts/event/search.applescript`, `search-range.applescript`, `recurring.applescript`, `alert.applescript`, `show.applescript`.
- `scripts/tests/dictionary_contract.sh`: contract test against Calendar.app scripting dictionary.
- `scripts/tests/smoke_calendar.sh`: smoke test for script layer (skips when Calendar.app not available).
- `.github/workflows/ci-pr.yml`: PR validation, auto-merge, version bump, tag, and release flow.
- `.github/workflows/ci-main.yml`: main-branch validation, patch tag, and release flow.

## Source of Truth

- `make dictionary-calendar` / `make dictionary-standard` for the live Calendar.app scripting dictionary.
- Live checks with `osascript` against Calendar.app.

## Pitfalls / Environment Limits

- Calendar.app automation may need **Calendars** or **Full Disk Access** permission (System Settings → Privacy & Security).
- iCloud vs local calendar accounts may behave differently.
- Recurring events may require special handling for individual vs series edits.

## Safety Rules

- Treat calendar data as real user data.
- Write operations (event/create, event/update, event/delete, calendar/subscribe) must be explicit.
- Use the `CodexTest_` prefix for any test data and clean up after tests.

## Validation

After making changes:
- run `make check` to ensure Calendar.app is available;
- run `make test` to run dictionary contract and smoke tests;
- run `make compile` to compile all AppleScript files (syntax check);
- update `SKILL.md` when command coverage changes.

## Editing Rules

- Keep docs in simple English.
- Do not claim support for a feature unless it is verified with `osascript` against Calendar.app.
- Never delete or modify calendar events without explicit user approval.
