local gears = require("gears")
local naughty = require("naughty")
local dpi = require("beautiful").xresources.apply_dpi

-- Naughty presets
naughty.config.padding = dpi(8)
naughty.config.spacing = dpi(8)

naughty.config.defaults.timeout = 5
naughty.config.defaults.screen = 1
naughty.config.defaults.position = 'top_right'
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.ontop = true
naughty.config.defaults.icon = nil
naughty.config.defaults.icon_size = dpi(32)
naughty.config.defaults.shape = gears.shape.rounded_rect
naughty.config.defaults.border_width = dpi(0)
naughty.config.defaults.hover_timeout = 10

-- Error handling

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end


-- Handle deprecation warnings
awesome.connect_signal("debug::deprecation", function (hint, see, args)
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Deprecation warning",
        text = hint .. '\nSee: ' .. see -- .. '\nArgs: ' .. tostring(table.unpack(args))
    })
end)

-- Global function that can be used to log something as a notification
function log_this(title, text)
    naughty.notify({
        title = 'log: ' .. title,
        text = text,
        timeout = 5
    })
end