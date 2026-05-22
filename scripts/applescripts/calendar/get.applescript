-- Get calendar properties (color, calendarIdentifier, writable, description). argv: calendarName [property]
-- If property omitted, outputs all; otherwise outputs single property.
on run argv
	if (count of argv) < 1 then
		return "Usage: get.applescript <calendarName> [property]"
	end if
	set calName to item 1 of argv
	set propName to ""
	if (count of argv) ≥ 2 then set propName to item 2 of argv

	tell application "Calendar"
		set c to calendar calName
		if propName is "color" then
			return color of c
		else if propName is "calendarIdentifier" or propName is "id" then
			return calendarIdentifier of c
		else if propName is "writable" then
			return writable of c
		else if propName is "description" then
			return description of c
		else if propName is "name" then
			return name of c
		else
			set output to "name: " & (name of c) & linefeed
			set output to output & "color: " & (color of c) & linefeed
			set output to output & "calendarIdentifier: " & (calendarIdentifier of c) & linefeed
			set output to output & "writable: " & (writable of c) & linefeed
			set output to output & "description: " & (description of c)
			return output
		end if
	end tell
end run
