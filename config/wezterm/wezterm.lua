local wt = require 'wezterm'
local mux = wt.mux

local c = wt.config_builder()
c.check_for_updates = false

local color_scheme = "Gruvbox dark, medium (base16)"
c.color_scheme = color_scheme

-- useful formatting vars
local nf = wt.nerdfonts
local gb = wt.color.get_builtin_schemes()[color_scheme]
-- font and color scheme
c.font = wt.font_with_fallback({
    {
        family = "IosevkaTerm Nerd Font",
    },
    "Noto Color Emoji",
    "JetBrains Mono",
})
c.font_size = 10

--tab bar set up
c.tab_bar_at_bottom = true
c.use_fancy_tab_bar = false
c.tab_max_width = 32
local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

local gbgrey = '#3c3836'
local gbgrey2 = '#504945'
local gbgrey3 = '#665c54'
wt.on(
  'format-tab-title',
  function(tab, _, _, _, _, _)
    local title = tab_title(tab)
    if tab.is_active then
      return {
        { Background = { Color = 'orange' } },
        { Foreground = { Color = gbgrey } },
        { Text = nf.pl_left_hard_divider },
        { Text = ' ' .. tab.tab_id .. ' ' .. nf.pl_left_soft_divider .. ' ' .. title .. ' ' },
        { Background = { Color = gbgrey } },
        { Foreground = { Color = 'orange' } },
        { Text = nf.pl_left_hard_divider },
      }
    end
    return {
      { Background = { Color = gbgrey2 } },
      { Foreground = { Color = gbgrey } },
      { Text = nf.pl_left_hard_divider },
      { Foreground = { Color = gb.selection_bg } },
      { Text = ' ' .. tab.tab_index .. ' ' .. nf.pl_left_soft_divider .. ' ' .. title .. ' ' },
      { Background = { Color = gbgrey } },
      { Foreground = { Color = gbgrey2 } },
      { Text = nf.pl_left_hard_divider },
    }
  end
)

-- status
wt.on('update-status', function(window, pane)
  local title = pane:get_title()
  window:set_left_status(wt.format {
    { Background = { Color = gbgrey3 } },
    { Text = ' ' .. title .. ' ' },
    { Foreground = { Color = gbgrey3 } },
    { Background = { Color = gbgrey } },
    { Text = nf.pl_left_hard_divider },
  })
end)
wt.on('update-right-status', function(window, pane)
  local date = wt.strftime '%Y-%m-%d'
  local time = wt.strftime '%H:%M'
  local host = mux.get_domain(pane:get_domain_name()):name()
  if host == "local" then
    host = wt.hostname()
  else
    host = string.gsub(host, '(.*):(.*)', '%2')
  end

  window:set_right_status(wt.format {
    { Foreground = { Color = gb.cursor_fg } },
    { Text = nf.pl_right_hard_divider },
    { Foreground = { Color = 'orange' } },
    { Background = { Color = gb.cursor_fg } },
    { Text = ' ' .. date .. ' ' .. nf.pl_right_soft_divider .. ' ' .. time .. ' ' .. nf.pl_right_hard_divider},
    { Foreground = { Color = gb.cursor_fg } },
    { Background = { Color = 'orange' } },
    { Text = ' ' .. host .. ' '},
  })
end)

-- keys
local keymap = require('keymap')
c.leader = keymap.leader
c.keys = keymap.keys

c.warn_about_missing_glyphs = false

c.window_background_opacity = 0.9
local sessions = wt.plugin.require("https://github.com/abidibo/wezterm-sessions")
sessions.apply_to_config(c)

-- merge tabs config
return c
