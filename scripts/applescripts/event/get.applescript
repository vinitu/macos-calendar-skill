-- Get event details. argv: calendarName summary (or calendarName eventId for id lookup)
-- Output includes attendee, status, uid, url (sdef)
on run argv
	if (count of argv) < 2 then
		return "Usage: get.applescript <calendar> <summary|eventId>"
	end if
	set calName to item 1 of argv
	set searchVal to item 2 of argv

	tell application "Calendar"
		tell calendar calName
			set evts to {}
			try
				-- try as summary first
				set evts to (every event whose summary is searchVal)
			end try
			if (count of evts) is 0 then
				try
					set evts to (every event whose uid is searchVal)
				end try
			end if
			if (count of evts) is 0 then
				return "Event not found"
			end if
			set e to item 1 of evts
			set output to "Summary: " & (summary of e) & linefeed
			set output to output & "Start: " & (start date of e) & linefeed
			set output to output & "End: " & (end date of e) & linefeed
			set output to output & "Location: " & (location of e) & linefeed
			set output to output & "Description: " & (description of e) & linefeed
			set output to output & "All-day: " & (allday event of e) & linefeed
			set output to output & "Status: " & (status of e) & linefeed
			set output to output & "UID: " & (uid of e) & linefeed
			set output to output & "URL: " & (url of e) & linefeed
			set output to output & "Attendees: "
			set atts to attendees of e
			if (count of atts) > 0 then
				repeat with a in atts
					set output to output & (display name of a) & " <" & (email of a) & "> " & (participation status of a) & "; "
				end repeat
				set output to output & linefeed
			else
				set output to output & "(none)" & linefeed
			end if
			return output
		end tell
	end tell
end run
