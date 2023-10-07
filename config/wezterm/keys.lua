local wt = require 'wezterm'
local act = wt.action

return {
    { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
    { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
    { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = '|', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
    { key = '"', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
    { key = ',', mods = 'LEADER', action = act.PromptInputLine {
        description = '(rename-tab)',
        action = wt.action_callback(function(window, pane, line)
            if line then
                window:active_tab():set_title(line)
            end
        end),
        },
    },
}

