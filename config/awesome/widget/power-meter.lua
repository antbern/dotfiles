-- local os = require('os');
local awful = require('awful');
-- local watch = require("awful.widget.watch")
local wibox = require('wibox');
-- local gears = require('gears');
-- local naughty = require('naughty');
-- local beautiful = require('beautiful');

-- local dpi = require("beautiful").xresources.apply_dpi

local power_cmd = '/home/antbern/.config/awesome/scripts/power_usage.sh'
local interval = 5

local widget = wibox.widget{
    -- markup = 'This <i>is</i> a <b>textbox</b>!!!',
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

awful.widget.watch(power_cmd, interval, function(_, stdout)
    widget.text = stdout
end, widget)

return widget