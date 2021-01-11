--[[
    Module: Exit Screen

    Listens to the global signal `module::exit_screen:show`
    to show an overlay containing options to lock, logout (exit),
    suspend, shutdown or reboot the computer.

    The signal `module::exit_screen:hide` additionally hides the
    exit screen on-demand.
]]


local awful = require('awful');
local wibox = require('wibox');
local gears = require('gears');
local beautiful = require('beautiful');

local dpi = require("beautiful").xresources.apply_dpi

local icon_font = 'RobotoMono NF 48'
local text_font = 'RobotoMono NF 14'

local icons = {
    lock = '',
    logout = '',
    suspend = '鈴',
    poweroff = '',
    reboot = 'ﰇ'
}


local suspend_callback = function()
    -- TODO: lock screen first
    awesome.emit_signal('module::exit_screen:hide')
    awful.spawn.with_shell('systemctl suspend')
end

local logout_callback = function()
    awesome.quit()
end
local lock_callback = function()
    awful.spawn.with_shell('i3lock-fancy')
    awesome.emit_signal('module::exit_screen:hide')
end

local poweroff_callback = function()
    awful.spawn.with_shell('poweroff')
end
local reboot_callback = function()
    awful.spawn.with_shell('reboot')
end



local create_button_widget = function(name, icon, callback)

    local btn_icon = wibox.widget{
        text = icon,
        align = 'center',
        -- valign = 'center',
        font = icon_font,
        widget = wibox.widget.textbox
    }

    local btn_text = wibox.widget{
        markup = name,
        font = text_font,
        widget = wibox.widget.textbox
    }

    local container = wibox.widget{
        {
            nil,
            {
                nil,
                btn_icon,
                expand = 'none',
                widget = wibox.layout.align.horizontal
            },
            {
                {
                    nil,
                    btn_text,
                    expand = 'none',
                    widget = wibox.layout.align.horizontal
                },
                bottom = dpi(20),
                widget = wibox.container.margin
            },
            -- expand = 'none',
            layout = wibox.layout.align.vertical
        },
        shape = gears.shape.rounded_rect,
        bg = '#000000',
        shape_border_color = '#000000',
        shape_border_width = dpi(2),
        forced_height = dpi(160),
        forced_width = dpi(160),
        widget = wibox.container.background
    }

    container:connect_signal('mouse::enter', function()
        container.bg = '#5a5a5a' -- beautiful.groups_bg
    end)
    container:connect_signal('mouse::leave', function()
        container.bg = '#000000' -- beautiful.leave_event
    end)

    container:connect_signal('button::press', function()
        container.bg = beautiful.press_event
    end)
    container:connect_signal('button::release', function()
        container.bg = '#5a5a5a' -- beautiful.release_event
        callback()
    end)

    return container

end

-- function that creates an exit screen on the specified screen
local create_exit_screen = function(s)

    -- create the backgroud wibox
    s.exit_screen = wibox{
        screen = s,
        type = 'spash',
        visible = false,
        ontop = true,
        -- opacity = 0.5,
        bg = '#1E23207f', --beautiful.background,
        fg = beautiful.fg_normal,
        width = s.geometry.width,
        height = s.geometry.height,
        x = s.geometry.x,
        y = s.geometry.y
    }

    -- connect mouse actions (middle and right)
    s.exit_screen:buttons(
        gears.table.join(
            awful.button({}, 2, function() 
                awesome.emit_signal('module::exit_screen:hide')
            end),
            awful.button({}, 3, function() 
                awesome.emit_signal('module::exit_screen:hide')
            end)
        )
    )

    -- configure layout and buttons
    s.exit_screen:setup{
        {
            create_button_widget("[L]ock", icons.lock, lock_callback),
            create_button_widget("[E]xit", icons.logout, logout_callback),
            create_button_widget("[S]uspend", icons.suspend, suspend_callback),
            create_button_widget("[P]ower Off", icons.poweroff, poweroff_callback),
            create_button_widget("[R]eboot", icons.reboot, reboot_callback),
            spacing = dpi(50),
            layout = wibox.layout.flex.horizontal
        },
        layout = wibox.container.place -- center on the screen
    }

end

-- screen.connect_signal('request::desktop_decoration',
awful.screen.connect_for_each_screen(function(s)
    create_exit_screen(s)
end)

local function hide_exit_screen()
    awesome.emit_signal('module::exit_screen:hide')
end

local keybinds = {
    ['escape'] = hide_exit_screen,
    ['q'] = hide_exit_screen,
    ['x'] = hide_exit_screen,
    ['s'] = suspend_callback,
    ['t'] = logout_callback,
    ['p'] = poweroff_callback,
    ['r'] = reboot_callback,
    ['l'] = lock_callback
}


-- keygrabber to allow keyboard control
local exit_screen_grabber = awful.keygrabber{
    keypressed_callback = function(self, mod, key, command)

        key = key:lower()

        if keybinds[key] then
            keybinds[key]()
            -- hide_exit_screen()
        end
    end
}



-- connect signals to show / hide the exit screen
awesome.connect_signal('module::exit_screen:show', function() 
    -- hide all exit screens
    for s in screen do
        s.exit_screen.visible = false
    end
    -- show the exit screen on the focused screen
    awful.screen.focused().exit_screen.visible = true
    exit_screen_grabber:start()
end)

awesome.connect_signal('module::exit_screen:hide', function() 
    exit_screen_grabber:stop()

    -- hide all exit screens
    for s in screen do
        s.exit_screen.visible = false
    end
end)