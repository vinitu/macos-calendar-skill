-- Add a display alarm to an event. argv: calendarName summary triggerIntervalMinutes
-- triggerInterval: negative = minutes before event (e.g. -60 = 1 hour before)
on run argv
	if (count of argv) < 3 then
		return "Usage: alert.applescript <calendar> <summary> <triggerIntervalMinutes>"
	end if
	set calName to item 1 of argv
	set sum to item 2 of argv
	set intervalMin to item 3 of argv as integer

	tell application "Calendar"
		tell calendar calName
			set evts to (every event whose summary is sum)
			if (count of evts) is 0 then
				return "Event not found"
			end if
			set e to item 1 of evts
			make new display alarm at end of display alarms of e with properties {trigger interval:intervalMin}
		end tell
	end tell
	return "alarm added"
end run
