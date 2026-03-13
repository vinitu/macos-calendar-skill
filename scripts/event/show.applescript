-- Show event in calendar window. argv: calendarName summary
on run argv
	if (count of argv) < 2 then
		return "Usage: show.applescript <calendar> <summary>"
	end if
	set calName to item 1 of argv
	set sum to item 2 of argv

	tell application "Calendar"
		tell calendar calName
			set evts to (every event whose summary is sum)
			if (count of evts) is 0 then
				return "Event not found"
			end if
			show item 1 of evts
		end tell
	end tell
	return "shown"
end run
