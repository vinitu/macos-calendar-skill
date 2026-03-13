-- Search events by summary substring. argv: [calendarName] query
on run argv
	if (count of argv) < 1 then
		return "Usage: search.applescript [calendar] <query>"
	end if
	set query to item -1 of argv
	set calName to ""
	if (count of argv) ≥ 2 then set calName to item 1 of argv

	tell application "Calendar"
		set output to ""
		if calName is not "" then
			tell calendar calName
				set evts to (every event whose summary contains query)
				repeat with e in evts
					set output to output & (start date of e) & " | " & (summary of e) & " | " & calName & linefeed
				end repeat
			end tell
		else
			repeat with c in calendars
				set evts to (every event of c whose summary contains query)
				repeat with e in evts
					set output to output & (start date of e) & " | " & (summary of e) & " | " & (name of c) & linefeed
				end repeat
			end repeat
		end if
		return output
	end tell
end run
