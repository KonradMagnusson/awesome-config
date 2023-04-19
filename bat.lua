local lain = require("lain")
local awful = require("awful")
local beautiful = require("beautiful")

local batwidget = awful.widget.watch(
    { awful.util.shell, "-c", "acpi" },
    10,
    function(widget, stdout)
		local Low = 35
		local Critical = 15

		local Green = "#00FF00"
		local Red = "#FF0000"
		local SomeKindaFuckinOrange = "#FFBF40"

		local IsCharging = stdout:match("Charging")
		local IsDischarging = stdout:match("Discharging")

		-- →↓↑
		local Status = IsCharging and "↑" or IsDischarging and "↓" or "→"
		local StatusColor = IsCharging and Green or IsDischarging and SomeKindaFuckinOrange or beautiful.fg_normal
		local StatusFmt = lain.util.markup(StatusColor, Status)

		local Perc = stdout:match("%d+%%")

		if IsDischarging then
			local color = beautiful.fg_normal
			local PercVal = tonumber(string.sub(Perc, 1, -2))

			if PercVal < Critical then
				color = Red
			elseif PercVal < Low then
				color = SomeKindaFuckinOrange
			end

			local PercFmt = lain.util.markup(color, Perc)
			widget:set_markup(PercFmt .. StatusFmt)
			return
		end

		widget:set_markup(Perc .. StatusFmt)
    end
)

return batwidget
