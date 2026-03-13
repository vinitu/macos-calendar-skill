-- Switch calendar view. argv: day view | week view | month view
on run argv
	if (count of argv) < 1 then
		return "Usage: switch-view.applescript <day view|week view|month view>"
	end if
	set viewName to item 1 of argv
	if viewName is "day" then set viewName to "day view"
	if viewName is "week" then set viewName to "week view"
	if viewName is "month" then set viewName to "month view"

	tell application "Calendar"
		switch view to viewName
	end tell
	return "switched"
end run
