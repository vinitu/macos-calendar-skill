-- List events in a date range. argv: startDate endDate (ISO format "YYYY-MM-DD" or "YYYY-MM-DD HH:MM:SS")
on run argv
	if (count of argv) < 2 then
		return "Usage: list-range.applescript <startDate> <endDate>"
	end if
	set startStr to item 1 of argv
	set endStr to item 2 of argv
	set startDate to date startStr
	set endDate to date endStr

	tell application "Calendar"
		set output to ""
		repeat with c in calendars
			set evts to (every event of c whose start date ≥ startDate and start date ≤ endDate)
			repeat with e in evts
				set output to output & (start date of e) & " | " & (summary of e) & " | " & (name of c) & linefeed
			end repeat
		end repeat
		return output
	end tell
end run
