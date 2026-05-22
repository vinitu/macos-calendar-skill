-- List all calendars with account name. One line per calendar: "Calendar Name (Account Name)"
tell application "Calendar"
	set output to ""
	repeat with c in calendars
		set output to output & (name of c) & " (" & (name of (account of c)) & ")" & linefeed
	end repeat
	return output
end tell
