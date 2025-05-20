local wt = require 'wezterm'
local act = wt.action
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
    { key = 'C', mods = 'LEADER|SHIFT', action = wt.action_callback(util.openTabInDomain)},
    { key = 'r', mods = 'LEADER',       action = wt.action_callback(util.openRemoteDomain)},
    { key = '|', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
    { key = '-', mods = 'LEADER',       action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
    { key = ',', mods = 'LEADER',       action = act.PromptInputLine { description = '(rename-tab)', action = wt.action_callback(util.setTabTitle)}},
    { key = 'PageUp', mods = 'SHIFT',   action = act.ScrollByPage(-1) },
    { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
    { key = 'PageUp', mods = 'LEADER',  action = act.ScrollByPage(-1) },
    { key = 'PageDown', mods = 'LEADER',action = act.ScrollByPage(1) },
    -- Navigator.nvim keybinds
    { key = 'h', mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-left') },
    { key = 'j', mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-down') },
    { key = 'k', mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-up') },
    { key = 'l', mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-right') },
    { key = 's', mods = 'LEADER',       action = act.PaneSelect{ alphabet='asdfghjkl;', mode='SwapWithActive'} },
    { key = 'p', mods = 'ALT',          action = act.PasteFrom("Clipboard")},
    { key = 'i', mods = 'LEADER|SHIFT', action = act.RotatePanes 'CounterClockwise' },
    { key = 'o', mods = 'LEADER|SHIFT', action = act.RotatePanes 'Clockwise' },
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
