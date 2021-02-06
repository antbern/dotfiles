local awful = require('awful');
local wibox = require('wibox');

local dpi = require("beautiful").xresources.apply_dpi

local playerctl_cmd = require('configuration.paths').script_dir .. 'playerctl_watch.py'

local factory = function()

    local status_widget = wibox.widget{
        markup = '',
        align  = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }

    local text_widget = wibox.widget{
        markup = '',
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

            -- log_this('Widget:Music:Line', line)
            -- text_widget.markup = line

            local status = line:sub(1, 1)
            local text = line:sub(2)

            if status == "p" then
                status_widget.markup = '<b>Playing</b> '
                text_widget.markup = '<i>' .. text .. "</i>"
            elseif status == "q" then
                status_widget.markup = '<b>Paused</b> '
                text_widget.markup = '<i>' .. text .. "</i>"
            elseif status == "s" then
                status_widget.markup = '<b>Nothing Playing</b>'
                text_widget.markup = ''
            end

        end,
        stderr = function(line)
            status_widget.markup = '<b>Error:</b> '
            text_widget.markup = line
        end,
        exit = function(reason, code)
            status_widget.markup = '<b>Exited</b>'
            text_widget.markup = string.format('reason=%s, code=%s', reason, code)
        end
    })
    
    return widget
end

return factory