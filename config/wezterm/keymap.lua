local wt = require 'wezterm'
local act = wt.action
local mux = wt.mux
local nav = require 'navigation'

local M = {}

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

M.leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 1000 }
M.keys = {
    { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
    { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
    { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
    --{ key = 'C', mods = 'LEADER|SHIFT', action = wt.action_callback(function(window, pane)
    --    local domains = {}
    --    for domain in mux.all_domains do
    --        if domain.has_any_panes then
    --            local label = "asdf"
    --            if label ~= nil then
    --                table.insert(domains, {label = label})
    --            end
    --        end
    --    end
    --    window:perform_action(act.InputSelector {
    --        title = 'Select Domain to create tab',
    --        choices = domains,
    --        action = wt.action_callback(function(_, _, _, label)
    --            if label then
    --                local domain = mux.get_domain(label)
    --                act.SpawnTab(domain)
    --            end
    --        end)
    --    },
    --    pane)
    --    end)
    --},
    { key = '|', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
    { key = '"', mods = 'LEADER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
    -- Navigator.nvim keybinds
    { key = 'h', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-left') },
    { key = 'j', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-down') },
    { key = 'k', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-up') },
    { key = 'l', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-right') },
    { key = ',', mods = 'LEADER', action = act.PromptInputLine {
        description = '(rename-tab)',
        action = wt.action_callback(function(window, _, line)
            if line then
                window:active_tab():set_title(line)
            end
        end),
        },
    },
}

return M
