-- Delete event(s) matching summary in calendar. argv: calendarName summary
on run argv
	if (count of argv) < 2 then
		return "Usage: delete.applescript <calendar> <summary>"
	end if
	set calName to item 1 of argv
	set sum to item 2 of argv

	tell application "Calendar"
		tell calendar calName
			set evts to (every event whose summary is sum)
			repeat with e in evts
				delete e
			end repeat
		end tell
	end tell
	return "deleted"
end run
