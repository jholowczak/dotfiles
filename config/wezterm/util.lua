-- util functions
local M = {}

M.openDomainTab = function(window, pane)
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
        action = wt.action_callback(function(win, _, _, label)
            if label then
                local domain = mux.get_domain(label)
                win:spawn_tab {domain = {DomainId = domain:domain_id()}}
            end
        end)
    },
    pane)
end

M.setTabTitle = function(window, _, line)
    if line then
        window:active_tab():set_title(line)
    end
end

return M
