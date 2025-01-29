-- tmux operations
vim.g.Tmuxlast_command = ""

function TmuxWindowExists()
    local output = vim.fn.system("tmux list-panes |grep 1:")
    if output == "" then
        return false
    else
        return true
    end
end

function TmuxToggle()
    if not TmuxWindowExists() then
        vim.g.Tmuxsession = vim.fn.system("tmux split-window -h")
        vim.fn.system("tmux select-pane -L")
    end
end

function TmuxSendCommand(txt)
    vim.g.Tmuxlast_command = txt

    if txt==nil or txt == "" then
        local input = vim.fn.input("tmux input: ")
        if input ~= "" then
            TmuxSendCommand(input)
        end
    else
        if TmuxWindowExists() then
            vim.fn.system("tmux send-keys -t 1 " .. "'" .. txt .. "\n'")
        else
            TmuxToggle()
            vim.fn.system("tmux send-keys -t 1 " .. "'" .. txt .. "\n'")
        end
    end
end

function TmuxSendLastCommand()
    TmuxSendCommand(vim.g.tmux_last_command)
end

local function TmuxSendBlock()
    local start = vim.fn.line(".")
    local _end = vim.fn.search("^$")
    local lines = vim.fn.getbufline(vim.fn.bufnr("%"), start, _end-1)
    for _,v in pairs(lines) do
        if v ~= "" then
            TmuxSendCommand(v)
        end
    end
    vim.fn.execute("normal! :" .. _end)
end

local function TmuxSendFunction()
    local start = vim.fn.line(".")
    vim.fn.execute("normal! ][")
    local _end = vim.fn.line(".")
    local lines = vim.fn.getbufline(vim.fn.bufnr("%"), start, _end)
    for _,v in pairs(lines) do
        if v == "" then
            TmuxSendCommand("\n")
        else
            TmuxSendCommand(v)
        end
    end
    vim.fn.execute("normal! :" .. _end)
end

function TmuxSendBuf()
    if string.find(vim.fn.getline("."), "function") ~= nil then
        TmuxSendFunction()
    else
        TmuxSendBlock()
    end
end
