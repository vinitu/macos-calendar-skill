-- Reload all calendar files contents (sdef: reload calendars)
on run argv
	tell application "Calendar"
		reload calendars
	end tell
	return "reloaded"
end run
