local gears = require("gears")
local awful = require("awful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

globalkeys = gears.table.join(
    awful.key({ modkey,           }, "h",		hotkeys_popup.show_help,
              { description = "show help",		group="awesome" }),
    awful.key({ modkey,           }, "j",		awful.tag.viewprev,
              { description = "view previous",	group = "tag" }),
    awful.key({ modkey,           }, "ö",		awful.tag.viewnext,
              { description = "view next",		group = "tag" }),
    awful.key({ modkey,           }, "q",		awful.tag.history.restore,
              { description = "go back",		group = "tag" }),


    -- Layout manipulation
    awful.key({ modkey, alt   }, "p",			function () awful.client.swap.byidx(  1)    end,
              { description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, alt   }, "u",			function () awful.client.swap.byidx( -1)    end,
              { description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, ctrl }, "j",			function () awful.screen.focus_relative( 1) end,
              { description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, ctrl }, "ö",			function () awful.screen.focus_relative(-1) end,
              { description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey, ctrl }, "u",			awful.client.urgent.jumpto,
              { description = "jump to urgent client", group = "client"}),

    awful.key({ modkey, alt }, "q",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    awful.key({ alt,		}, "Tab",		function () awful.client.focus.byidx( 1) end,
        { description = "focus next by index", group = "client" }),
    awful.key({ alt, shift	}, "Tab",		function () awful.client.focus.byidx(-1) end,
        { description = "focus previous by index", group = "client" }),

    -- Standard program
    awful.key({ modkey,           }, "d", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, ctrl }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, shift   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "p",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "u",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, shift   }, "o",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, shift   }, "i",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, ctrl }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, ctrl }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, shift   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, ctrl }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.spawn("dmenu_run -b") end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().promptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),

    -- Menubar
    awful.key({ modkey, shift  }, "r", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

return globalkeys
