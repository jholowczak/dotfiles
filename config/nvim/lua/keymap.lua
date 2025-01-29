-- KEYMAPS
require 'utils.keys'

vim.mapleader = " "
vim.g.mapleader = " "
vim.maplocalleader = ","
vim.g.maplocalleader = ","

Kmap("n", "<l>nm", ":bprevious<cr>")
Kmap("n", "<l>nn", ":bnext<cr>")
Kmap("n", "<l>nd", ":bdelete<cr>")
Kmap("n", "<l>no", ":only<cr>")
Kmap("n", "<l>ns", "<C-W><C-W>")
Kmap("n", "<l>nb", ":CtrlPBuffer<cr>")
Kmap("n", "<l>j", "<C-d>")
Kmap("n", "<l>k", "<C-u>")
Kmap("n", "<l>=", "<C-w>=")
Kmap("n", "<l>-", ":res -5<cr>")
Kmap("n", "<l>+", ":res +5<cr>")
Kmap("n", "<l>nt", ":NvimTreeOpen<cr>")
Kmap("n", "<l>ss", ":setlocal spell spelllang=en_us<cr>")
Kmap("n", "<l>sf", ":setlocal nospell<cr>")
Kmap("n", "<l>sn", "]s")
Kmap("n", "<l>sp", "[s")
Kmap("n", "<l>sr", "z=")
Kmap("n", "<l>sa", "zg")
--Kmap("n", "<l>rr", tmux_send_buf)
--Kmap("n", "<l>vp", tmux_send_command)
--Kmap("n", "<l>vl", tmux_send_last_command)
--Kmap("n", "<l>mb", ":lua tmux_send_command('git blame -L ' .. vim.fn.line('.') .. ',' .. vim.fn.line('.') .. ' ' .. vim.fn.expand('%:p'))<cr>", opts)
Kmap('n', '<l>dd', ":lua vim.diagnostic.open_float")
Kmap({ "n", "x" }, "<l>rs", require("ssr").open)
Kmap("n", "<l>ns", ":Telescope possession list<cr>")
Kmap("n", "<l>T", ":TodoQuickFix<cr>")
Kmap("n", "]t", require('todo-comments').jump_next)
Kmap("n", "[t", require('todo-comments').jump_prev)

--  GIT
Kmap("n", "<l>ms", function()
    require('neogit').open({ kind = "split" })
end)
Kmap("n", "<l>mb", ":BlameToggle<cr>")
Kmap("n", "<l>mB", ":BlameToggle virtual<cr>")


Kmap("n", "<l><l>b", "<cmd>HopWordBC<CR>")
Kmap("n", "<l><l>w", "<cmd>HopWordAC<CR>")
Kmap("n", "<l><l>j", "<cmd>HopLineAC<CR>")
Kmap("n", "<l><l>k", "<cmd>HopLineBC<CR>")
Kmap("v", "<l><l>w", "<cmd>HopWordAC<CR>")
Kmap("v", "<l><l>b", "<cmd>HopWordBC<CR>")
Kmap("v", "<l><l>j", "<cmd>HopLineAC<CR>")
Kmap("v", "<l><l>k", "<cmd>HopLineBC<CR>")

-- multiplexer movement keybinds
local nav = require("Navigator")
Kmap('n', "<C-h>", nav.left)
Kmap('n', "<C-j>", nav.down)
Kmap('n', "<C-k>", nav.up)
Kmap('n', "<C-l>", nav.right)
Kmap('n', "<C-\\>", nav.previous)
--Kmap('n', "<C-Space>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<cr>", opts)
--
-- Language-specific binds
local fileTypeBindings = {
    {   pattern = { "c", "cpp", "ocaml" },
        binds = {
            { keys = "<l>gr",
              cmd  = ":!make run<cr>"},
            { keys = "<l>gt",
              cmd  = ":!make test<cr>"},
            { keys = "<l>gb",
              cmd  = ":!make<cr>"}
        }
    },
    {   pattern = { "c", "cpp", "javascript" },
        binds = {
            { keys = "<l>gf",
              cmd  = ":!ClangFormat<cr>" }
        }
    },
    {   pattern = { "haskell" },
        binds = {
            { keys = "<l>gr",
              cmd  = ":!stack run<cr>" },
            { keys = "<l>gt",
              cmd  = ":!stack test<cr>" },
            { keys = "<l>gb",
              cmd  = ":!stack build<cr>" },
            { keys = "<l>ge",
              cmd  = ":!stack %" },
            { keys = "<l>t",
              cmd  = ":!GhcModType<cr>" }
        }
    },
    {   pattern = { "rust" },
        binds = {
            { keys = "<l>gr",
              cmd  = ":Cargo run<cr>" },
            { keys = "<l>gt",
              cmd  = ":Cargo test<cr>" },
            { keys = "<l>gc",
              cmd  = ":Cargo check<cr>" },
            { keys = "<l>gb",
              cmd  = ":Cargo build<cr>" },
            { keys = "<l>gB",
              cmd  = ":Cargo build --release<cr>" }
        },
        config = {
            rustfmt_autosave = 1,
        }
    },
    {   pattern = { "go" },
        binds = {
            { keys = "<l>gr",
              cmd  = ":GoRun<cr>" },
            { keys = "<l>gR",
              cmd  = ":GoRename<cr>" },
            { keys = "<l>gT",
              cmd  = ":GoTest -count=1<cr>" },
            { keys = "<l>gt",
              cmd  = ":GoTestFunc -count=1<cr>" },
            { keys = "<l>gv",
              cmd  = ":GoTestFunc -v -count=1<cr>" },
            { keys = "<l>gV",
              cmd  = ":GoTest -v -count=1<cr>" },
            { keys = "<l>gb",
              cmd  = ":GoBuild<cr>" },
            { keys = "<l>gS",
              cmd  = ":GoFillStruct<cr>" },
            { keys = "<l>gf",
              cmd  = ":!cd %:p:h && go test && cd -<cr>" },
            { keys = "<l>gj",
              cmd  = ":GoAddTag<cr>" },
            { keys = "<l>t",
              cmd  = ":GoInfo<cr>" },
            { keys = "<l>rt",
              cmd  = ":wa<CR> :GolangTestCurrentPackage<CR>",
              buf = true },
            { keys = "<l>rf",
              cmd  = ":wa<CR> :GolangTestFocused<CR>",
              buf = true },
        }
    },
--if has('macunix')
--    autocmd FileType python nnoremap <buffer><leader>rr :!python3 %<cr>
--    autocmd FileType python nnoremap <buffer><leader>rt :!python3 -m pytest -s %<cr>
--else
--    autocmd FileType python nnoremap <buffer><leader>rr :!python %<cr>
--    autocmd FileType python nnoremap <buffer><leader>rt :!python -m pytest -s %<cr>
--endif
    {   pattern = { "python" },
        binds = {
            { keys = "<l>rl",
              cmd  = ":!pylint %<cr>" },
            { keys = "<l>rb",
              cmd  = ":!/usr/bin/black %<cr>",
              buf = true },
            --{ keys = "<l>rr",
            --  cmd  = function()
            --      if vim.fn.has('macunix') then
            --          os.execute()
            --      else
            --
            --      end
            --  end,
            --  buf = true },
          }
    },
    {   pattern = { "sh" },
        binds = {
            { keys = "<l>rr",
              cmd  = ":!./%<CR>",
              buf = true },
          }
    },
    {   pattern = { "arduino" },
        binds = {
            { keys = "<l>aa",
              cmd = "<cmd>ArduinoAttach<CR>",
              buf = true },
            { keys = "<l>av",
              cmd = "<cmd>ArduinoVerify<CR>",
              buf = true },
            { keys = "<l>au",
              cmd = "<cmd>ArduinoUpload<CR>",
              buf = true },
            { keys = "<l>aus",
              cmd = "<cmd>ArduinoUploadAndSerial<CR>",
              buf = true },
            { keys = "<l>as",
              cmd = "<cmd>ArduinoSerial<CR>",
              buf = true },
            { keys = "<l>ab",
              cmd = "<cmd>ArduinoChooseBoard<CR>",
              buf = true },
            { keys = "<l>ap",
              cmd = "<cmd>ArduinoChooseProgrammer<CR>",
              buf = true },
        }
    },
    {   pattern = { "neorg" },
        binds = {
            { keys = "<localleader>r",
              cmd = "<cmd>MdEval<CR>",
              buf = true },
            { keys = "<localleader>nt",
              cmd = "<cmd>Neorg toc<CR>",
              buf = true },
        }
    },
    {   pattern = { "r" },
        binds = {
            { keys = "<l>rr",
              cmd = TmuxSendBuf,
              buf = true },
            { keys = "<l>vp",
              cmd = TmuxSendCommand,
              buf = true },
            { keys = "<l>vl",
              cmd = TmuxSendLastCommand,
              buf = true },
        }
    },
}

for _, lang in pairs(fileTypeBindings) do
    for _, block in pairs(lang.binds) do
        vim.api.nvim_create_autocmd("FileType", {
            pattern = lang.pattern,
            callback = function()
                if block.buf then
                    Kmap('n', block.keys, block.cmd, {buffer = block.buf})
                else
                    Kmap('n', block.keys, block.cmd)
                end
            end
        })
    end
    if lang.config then
        for k, v in pairs(lang.config) do
            vim.g[k] = v
        end
    end
end

--
-- Easy access to configuration files and loading
local configFiles = {
    {k="<l>co", t="edit", p="~/.config/nvim/init.lua"},
    {k="<l>ck", t="edit", p="~/.config/nvim/lua/keymap.lua"},
    {k="<l>cp", t="edit", p="~/.config/nvim/lua/plugins.lua"},
    {k="<l>cl", t="edit", p="~/.config/nvim/lua/lsp.lua"},
    {k="<l>cR", t="source", p="~/.config/nvim/init.lua"},
}

for _, c in pairs(configFiles) do
    Kmap("n", c.k, ":" .. c.t .. " " .. c.p .."<cr>")
    local rep = c.p:gsub("~", "*")
    vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
        pattern = { rep },
        callback = function()
            Kmap('n', c.k, ":bdelete<cr>")
        end
    })
    vim.api.nvim_create_autocmd({"BufLeave", "BufDelete"}, {
        pattern = { rep },
        callback = function()
            Kmap("n", c.k, ":" .. c.t .. " " .. c.p .."<cr>")
        end
    })
end

