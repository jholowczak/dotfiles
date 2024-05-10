local wt = require 'wezterm'
local act = wt.action
local mux = wt.mux
local nav = require 'navigation'
local util = require 'util'

local M = {}

M.leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 1000 }
M.keys = {
    { key = 'q', mods = 'LEADER',       action = act.CloseCurrentPane {confirm = false} },
    { key = 'Q', mods = 'LEADER|SHIFT', action = act.CloseCurrentTab {confirm = true} },
    { key = 'n', mods = 'LEADER',       action = act.ActivateTabRelative(1) },
    { key = 'p', mods = 'LEADER',       action = act.ActivateTabRelative(-1) },
    { key = 'c', mods = 'LEADER',       action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'C', mods = 'LEADER|SHIFT', action = wt.action_callback(util.openDomainTab)},
    { key = '|', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
    { key = '-', mods = 'LEADER',       action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
    { key = ',', mods = 'LEADER',       action = act.PromptInputLine { description = '(rename-tab)', action = wt.action_callback(util.setTabTitle)}},
    -- Navigator.nvim keybinds
    { key = 'h', mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-left') },
    { key = 'j', mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-down') },
    { key = 'k', mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-up') },
    { key = 'l', mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-right') },
}

-- for Navigator.nvim
wt.on('ActivatePaneDirection-right', function(window, pane)
    nav.conditionalActivatePane(window, pane, 'Right', 'l')
end)
wt.on('ActivatePaneDirection-left', function(window, pane)
    nav.conditionalActivatePane(window, pane, 'Left', 'h')
end)
wt.on('ActivatePaneDirection-up', function(window, pane)
    nav.conditionalActivatePane(window, pane, 'Up', 'k')
end)
wt.on('ActivatePaneDirection-down', function(window, pane)
    nav.conditionalActivatePane(window, pane, 'Down', 'j')
end)


return M
