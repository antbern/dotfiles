local awful = require('awful');
local wibox = require('wibox');

local dropbox_cmd = '/home/antbern/.cargo/bin/dropboxignore check --summary /home/antbern/Dropbox/'
local interval = 60

local factory = function()
	local textbox = wibox.widget {
		align  = 'center',
		valign = 'center',
		widget = wibox.widget.textbox
	}
	local widget = wibox.widget {
		textbox,
		width    = 75,
		strategy = "min",
		layout   = wibox.container.constraint
	}

	return awful.widget.watch(dropbox_cmd, interval, function(_, _, stderr)
		textbox:set_text(stderr)
	end, widget)
end

return factory
