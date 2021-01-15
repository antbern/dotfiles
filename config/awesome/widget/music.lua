-- local os = require('os');
local awful = require('awful');
-- local watch = require("awful.widget.watch")
local wibox = require('wibox');
-- local gears = require('gears');
local naughty = require('naughty');
-- local beautiful = require('beautiful');

local dpi = require("beautiful").xresources.apply_dpi

local playerctl_cmd = 'playerctl metadata --format "<b>{{status}}</b> | <i>{{title}} | {{artist}} | {{album}}</i>" --follow'

local function format_output(line)

    local s, e = string.find(line, '|', 0, true)

    local status = string.sub(line, 0, s-1)
    local therest = string.sub(line, e+1, -1)

    -- for w in line:gmatch("([^|]+)") do 
    --     naughty.notify { text = "LINE split:"..w }
    -- end
    -- naughty.notify { text = "LINE status:"..status..", rest:"..therest}

    return status, therest
end


local factory = function()

    local status_widget = wibox.widget{
        markup = 'STATUS',
        align  = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }

    local text_widget = wibox.widget{
        markup = 'TEXT',
        align  = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }

    local widget = wibox.widget{
        
        status_widget,
        {
            text_widget,
            max_size = dpi(200),
            -- step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
            -- step_function = wibox.container.scroll.step_functions.linear_back_and_forth,
            step_function = wibox.container.scroll.step_functions.linear_increase,
            speed = 20,
            widget = wibox.container.scroll.horizontal
        },
        layout = wibox.layout.fixed.horizontal
    }

    awful.spawn.with_line_callback(playerctl_cmd, {
        stdout = function(line)
            
            -- update status here

            -- playerctl returns empty line when there is no player available
            if line == '' then
                -- naughty.notify { text = "LINE: Empty" }
                status_widget.markup = '<b>Nothing Playing</b>'
            else
                -- naughty.notify { text = "LINE:"..line }

                status_widget.markup, text_widget.markup = format_output(line)
            end

        end,
        stderr = function(line)
            status_widget.markup = '<b>Error:</b> '..line
        end,
        exit = function(reason, code)
            status_widget.markup = string.format('<b>Exited</b> reason=%s, code=%s', reason, code)
            text_widget.markup = ''
            -- naughty.notify { text = "EXIT:"..reason..", code:"..code}
        end
    })

    
    return widget
end

return factory