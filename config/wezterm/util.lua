-- util functions
local wt = require 'wezterm'
local act = wt.action
local mux = wt.mux

local M = {}

M.openTabInDomain = function(window, pane)
    local domains = {}
    for _, domain in pairs(mux.all_domains()) do
        if domain:has_any_panes() then
            local label = domain:name()
            if label ~= nil then
                table.insert(domains, {label = label})
            end
        end
    end
    window:perform_action(act.InputSelector {
        title = 'Select Domain to create tab',
        choices = domains,
        fuzzy = true,
        action = wt.action_callback(function(win, _, _, label)
            if label then
                local domain = mux.get_domain(label)
                win:spawn_tab {domain = {DomainId = domain:domain_id()}}
            end
        end)
    },
    pane)
end

local remoteName = function(window, pane, _, label)
    if label then
        window:perform_action(act.PromptInputLine{
            description = '(name)',
            action = wt.action_callback(function(w,p,line)
                local dn = label .. ':' .. line
                w:perform_action(act.SpawnTab { DomainName = dn }, p)
            end)
        }, pane)
    end
end

M.openRemoteDomain = function(window, pane)
    window:perform_action(act.InputSelector {
        title = 'Remote Type',
        choices = {
            { label = 'SSH' },
            { label = 'SSHMUX' },
        },
        action = wt.action_callback(remoteName)
    }, pane)
end

M.setTabTitle = function(window, _, line)
    if line then
        window:active_tab():set_title(line)
    end
end

return M
