-- TODO:
-- Cursor blink
-- Center terminal

local wezterm = require("wezterm")

local merge_tables = function(first_table, second_table)
	for k, v in pairs(second_table) do
		first_table[k] = v
	end
	return first_table
end

-- https://github.com/wez/wezterm/issues/2854#issue-1490277355
local extract_tab_bar_colors_from_theme = function(theme_name)
	local wez_theme = wezterm.color.get_builtin_schemes()[theme_name]
	return {
		tab_bar_colors = {
			active_tab = {
				bg_color = wezterm.color.parse(wez_theme.background):darken(1.0),
				fg_color = wez_theme.foreground,
			},
			inactive_tab = {
				bg_color = wez_theme.background,
				fg_color = wezterm.color.parse(wez_theme.background):lighten(0.5),
			},
			inactive_tab_edge = wezterm.color.parse(wez_theme.background):darken(1.0),
			inactive_tab_hover = {
				bg_color = wezterm.color.parse(wez_theme.background):lighten(0.1),
				fg_color = wezterm.color.parse(wez_theme.background):lighten(0.8),
			},
			new_tab = {
				bg_color = wez_theme.background,
				fg_color = wezterm.color.parse(wez_theme.background):lighten(0.8),
			},
			new_tab_hover = {
				bg_color = wezterm.color.parse(wez_theme.background):lighten(0.1),
				fg_color = wezterm.color.parse(wez_theme.background):lighten(1.0),
			},
		},
		window_frame_colors = {
			active_titlebar_bg = wezterm.color.parse(wez_theme.background):darken(1.0),
			inactive_titlebar_bg = wez_theme.background,
		},
	}
end

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local color_scheme = "Dracula (Official)"
local font = "Cascadia Code"
local tab_bar_theme = extract_tab_bar_colors_from_theme(color_scheme)

return merge_tables(config, {
	color_scheme = color_scheme,
	colors = {
		tab_bar = tab_bar_theme.tab_bar_colors,
	},
	default_domain = "WSL:Ubuntu",
	font = wezterm.font(font),
	inactive_pane_hsb = {
		brightness = 0.1,
	},
	-- https://wezfurlong.org/wezterm/config/lua/keyassignment/QuickSelectArgs.html
	keys = {
		{
			action = wezterm.action.QuickSelectArgs({
				action = wezterm.action_callback(function(window, pane)
					local url = window:get_selection_text_for_pane(pane)
					wezterm.log_info("opening: " .. url)
					wezterm.open_with(url)
				end),
				label = "open url",
				patterns = {
					"https?://\\S+",
				},
			}),
			key = "H",
			mods = "CTRL",
		},
	},
	-- Match AWS SSO login codes.
	quick_select_patterns = {
		"[A-Z]{4}-[A-Z]{4}",
	},
	window_background_image = "C:\\Users\\AndreasNäsman\\Pictures\\Wallpaper\\deathstar.jpg",
	window_background_image_hsb = {
		brightness = 0.2,
	},
	window_frame = merge_tables(tab_bar_theme.window_frame_colors, {
		font = wezterm.font(font, { weight = "Bold" }),
	}),
	window_padding = {
		bottom = 0,
		left = "1cell",
		right = 0,
		top = 0,
	},
})
