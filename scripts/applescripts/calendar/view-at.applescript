-- View calendar at a given date. argv: date (ISO "YYYY-MM-DD")
on run argv
	if (count of argv) < 1 then
		return "Usage: view-at.applescript <date>"
	end if
	set d to date (item 1 of argv)

	tell application "Calendar"
		view calendar at d
	end tell
	return "viewed"
end run
