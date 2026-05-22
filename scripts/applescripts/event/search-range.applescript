-- Search events in date range by summary substring. argv: startDate endDate query
on run argv
	if (count of argv) < 3 then
		return "Usage: search-range.applescript <startDate> <endDate> <query>"
	end if
	set startStr to item 1 of argv
	set endStr to item 2 of argv
	set query to item 3 of argv
	set startDate to date startStr
	set endDate to date endStr

	tell application "Calendar"
		set output to ""
		repeat with c in calendars
			set evts to (every event of c whose start date ≥ startDate and start date ≤ endDate and summary contains query)
			repeat with e in evts
				set output to output & (start date of e) & " | " & (summary of e) & linefeed
			end repeat
		end repeat
		return output
	end tell
end run
