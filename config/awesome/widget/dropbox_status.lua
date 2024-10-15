-- local os = require('os');
local awful = require('awful');
-- local watch = require("awful.widget.watch")
local wibox = require('wibox');
-- local gears = require('gears');
-- local naughty = require('naughty');
-- local beautiful = require('beautiful');

-- local dpi = require("beautiful").xresources.apply_dpi

local dropbox_cmd = 'dropbox status'
local interval = 5

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

	return awful.widget.watch(dropbox_cmd, interval, function(_, stdout)
		textbox:set_text(stdout)
	end, widget)
end

return factory
