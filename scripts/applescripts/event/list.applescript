-- List today's events across all calendars. One line per event: "start - end | summary"
set todayStart to current date
set hours of todayStart to 0
set minutes of todayStart to 0
set seconds of todayStart to 0
set todayEnd to todayStart + 1 * days

tell application "Calendar"
	set output to ""
	repeat with c in calendars
		set evts to (every event of c whose start date ≥ todayStart and start date < todayEnd)
		repeat with e in evts
			set output to output & (start date of e) & " - " & (end date of e) & " | " & (summary of e) & linefeed
		end repeat
	end repeat
	return output
end tell
