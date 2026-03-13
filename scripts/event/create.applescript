-- Create an event. argv: calendarName summary startDateTime endDateTime [location] [description] [allday]
-- Example: create.applescript "Home" "Meeting" "2026-03-15 10:00:00" "2026-03-15 11:00:00"
on run argv
	if (count of argv) < 4 then
		return "Usage: create.applescript <calendar> <summary> <start> <end> [location] [description] [allday]"
	end if
	set calName to item 1 of argv
	set sum to item 2 of argv
	set startStr to item 3 of argv
	set endStr to item 4 of argv
	set loc to ""
	set desc to ""
	set allday to false
	if (count of argv) ≥ 5 then set loc to item 5 of argv
	if (count of argv) ≥ 6 then set desc to item 6 of argv
	if (count of argv) ≥ 7 and (item 7 of argv is "true" or item 7 of argv is "1") then set allday to true

	tell application "Calendar"
		tell calendar calName
			make new event with properties {summary:sum, start date:date startStr, end date:date endStr, location:loc, description:desc, allday event:allday}
		end tell
	end tell
	return "created"
end run
