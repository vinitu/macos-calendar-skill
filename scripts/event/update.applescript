-- Update an event. argv: calendarName summary newStart newEnd [newSummary]
-- Or: calendarName summary --summary "New Title" (change title only)
on run argv
	if (count of argv) < 3 then
		return "Usage: update.applescript <calendar> <summary> <newStart> <newEnd> [newSummary]"
	end if
	set calName to item 1 of argv
	set sum to item 2 of argv

	tell application "Calendar"
		tell calendar calName
			set evts to (every event whose summary is sum)
			if (count of evts) is 0 then
				return "Event not found"
			end if
			set e to item 1 of evts
			if (count of argv) ≥ 4 then
				set startStr to item 3 of argv
				set endStr to item 4 of argv
				set start date of e to date startStr
				set end date of e to date endStr
			end if
			if (count of argv) ≥ 5 then
				set summary of e to item 5 of argv
			end if
		end tell
	end tell
	return "updated"
end run
