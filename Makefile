.PHONY: dictionary-calendar compile check test test-dictionary test-smoke

dictionary-calendar:
	@sdef /System/Applications/Calendar.app

compile:
	@set -euo pipefail; \
	find scripts -name '*.applescript' -print | while IFS= read -r file; do \
		osacompile -o /tmp/$$(echo "$$file" | tr '/' '_' | sed 's/\.applescript$$/.scpt/') "$$file"; \
	done

check:
	@osascript -e 'tell application "Calendar" to get name' >/dev/null || { echo "check: Calendar.app not available"; exit 1; }
	@echo "Calendar.app is available"

test: test-dictionary test-smoke

test-dictionary:
	@bash tests/dictionary_contract.sh

test-smoke:
	@bash tests/smoke_calendar.sh
