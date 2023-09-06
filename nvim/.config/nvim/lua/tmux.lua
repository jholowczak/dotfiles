-- tmux operations
vim.g.tmux_last_command = ""

function tmux_window_exists()
    local output = vim.fn.system("tmux list-panes |grep 1:")
    if output == "" then
        return false
    else
        return true
    end
end

function tmux_toggle() 
    if not tmux_window_exists() then
        vim.g.tmux_session = vim.fn.system("tmux split-window -h")
        vim.fn.system("tmux select-pane -L")
    end
end

function tmux_send_command(txt)
    vim.g.tmux_last_command = txt

    if txt == "" then
        local input = vim.fn.input("tmux input: ")
        if input ~= "" then
            tmux_send_command(input)
        end 
    else
        if tmux_window_exists() then
            vim.fn.system("tmux send-keys -t 1 " .. "'" .. txt .. "\n'") 
        else
            tmux_toggle()
            vim.fn.system("tmux send-keys -t 1 " .. "'" .. txt .. "\n'") 
        end
    end
end

function tmux_send_last_command() 
    tmux_send_command(vim.g.tmux_last_command) 
end

local function tmux_send_block() 
    local start = vim.fn.line(".")
    local _end = vim.fn.search("^$")
    local lines = vim.fn.getbufline(vim.fn.bufnr("%"), start, _end-1)
    for k,v in pairs(lines) do
        if v ~= "" then
            tmux_send_command(v)
        end
    end
    vim.fn.execute("normal! :" .. _end)
end

local function tmux_send_function()
    local start = vim.fn.line(".")
    vim.fn.execute("normal! ][")
    local _end = vim.fn.line(".")
    local lines = vim.fn.getbufline(vim.fn.bufnr("%"), start, _end)
    for k,v in pairs(lines) do
        if v == "" then
            tmux_send_command("\n")
        else
            tmux_send_command(v)
        end
    end
    vim.fn.execute("normal! :" .. _end)
end

function tmux_send_buf()
    if string.find(vim.fn.getline("."), "function") ~= nil then
        tmux_send_function()
    else
        tmux_send_block()
    end
end
