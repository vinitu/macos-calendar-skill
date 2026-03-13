-- Create a recurring event. argv: calendarName summary start end recurrenceRule
-- recurrenceRule: e.g. "FREQ=WEEKLY;BYDAY=MO;COUNT=12" or "FREQ=DAILY;COUNT=30"
on run argv
	if (count of argv) < 5 then
		return "Usage: recurring.applescript <calendar> <summary> <start> <end> <recurrenceRule>"
	end if
	set calName to item 1 of argv
	set sum to item 2 of argv
	set startStr to item 3 of argv
	set endStr to item 4 of argv
	set recStr to item 5 of argv

	tell application "Calendar"
		tell calendar calName
			set newEvent to make new event with properties {summary:sum, start date:date startStr, end date:date endStr}
			set recurrence of newEvent to recStr
		end tell
	end tell
	return "created"
end run
