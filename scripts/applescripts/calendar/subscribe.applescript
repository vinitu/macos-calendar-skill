-- Subscribe to a remote calendar (webcal or http URL). argv: url
on run argv
	if (count of argv) < 1 then
		return "Usage: subscribe.applescript <url>"
	end if
	set urlStr to item 1 of argv

	tell application "Calendar"
		GetURL urlStr
	end tell
	return "subscribed"
end run
