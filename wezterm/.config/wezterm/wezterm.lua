local wezterm = require("wezterm")

local config = wezterm.config_builder()
local act = wezterm.action

-- Constants
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
local ACTIVE_BG = "#3e4452"
local ACTIVE_FG = "#aab2bf"
local INACTIVE_BG = "#282c34"
local INACTIVE_FG = "#aab2bf"
local TRANSPARENT = "rgba(0,0,0,0)"

-- Basic configuration
config.automatically_reload_config = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.window_decorations = "RESIZE"
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium", stretch = "Normal", style = "Normal" })
config.font_size = 13
config.initial_rows = 40
config.initial_cols = 100
config.color_scheme = "Gruvbox Dark (Gogh)"

config.colors = {
	tab_bar = {
		background = TRANSPARENT,
	},
}

-- Helper functions
local function getTabTitle(tab_info)
	local process_name = tab_info.active_pane.foreground_process_name
	return string.gsub(process_name, "(.*[/\\])(.*)", "%2")
end

local function createTabItem(background, foreground, text)
	return {
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = text },
	}
end

-- Tab formatting
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = getTabTitle(tab)
	local index = tab.tab_index + 1
	local is_first = index == 1
	local is_last = index == #tabs
	title = wezterm.truncate_right(title, max_width - 2)

	local items = {}

	if tab.is_active then
		items = createTabItem(ACTIVE_BG, ACTIVE_FG, string.format(" %d  %s ", index, title))

		if is_first and #tabs > 1 then
			table.insert(items, { Background = { Color = INACTIVE_BG } })
		else
			table.insert(items, { Background = { Color = TRANSPARENT } })
		end
		table.insert(items, { Foreground = { Color = ACTIVE_BG } })
	else
		items = createTabItem(INACTIVE_BG, INACTIVE_FG, string.format(" %d  %s ", index, title))

		if is_last then
			table.insert(items, { Background = { Color = TRANSPARENT } })
		elseif tabs[index + 1] and tabs[index + 1].is_active then
			table.insert(items, { Background = { Color = ACTIVE_BG } })
		else
			table.insert(items, { Background = { Color = INACTIVE_BG } })
		end
		table.insert(items, { Foreground = { Color = INACTIVE_BG } })
	end

	table.insert(items, { Text = SOLID_RIGHT_ARROW })
	return items
end)

return config
