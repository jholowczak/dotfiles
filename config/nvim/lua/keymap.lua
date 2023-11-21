-- KEYMAPS
require 'utils.keys'

vim.mapleader = " "
vim.g.mapleader = " "

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
Kmap("n", "<l>rr", ":lua tmux_send_buf()<cr>")
Kmap("n", "<l>vp", ":lua tmux_send_command('')<cr>")
Kmap("n", "<l>vl", ":lua tmux_send_last_command()<cr>")
--Kmap("n", "<l>mb", ":lua tmux_send_command('git blame -L ' .. vim.fn.line('.') .. ',' .. vim.fn.line('.') .. ' ' .. vim.fn.expand('%:p'))<cr>", opts)
Kmap('n', '<l>dd', '<cmd>lua vim.diagnostic.open_float()<cr>')
Kmap("n", "<l>ms", "<cmd>lua require('neogit').open({ kind = \"split\" })<cr>")
vim.keymap.set({ "n", "x" }, "<leader>rs", function() require("ssr").open() end)
Kmap("n", "<l>ns", ":Telescope possession list<cr>")



Kmap("n", "<l><l>b", "<cmd>HopWordBC<CR>")
Kmap("n", "<l><l>w", "<cmd>HopWordAC<CR>")
Kmap("n", "<l><l>j", "<cmd>HopLineAC<CR>")
Kmap("n", "<l><l>k", "<cmd>HopLineBC<CR>")
Kmap("v", "<l><l>w", "<cmd>HopWordAC<CR>")
Kmap("v", "<l><l>b", "<cmd>HopWordBC<CR>")
Kmap("v", "<l><l>j", "<cmd>HopLineAC<CR>")
Kmap("v", "<l><l>k", "<cmd>HopLineBC<CR>")
-- TMUX movement keybinds
Kmap('n', "<C-h>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>")
Kmap('n', "<C-j>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>")
Kmap('n', "<C-k>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>")
Kmap('n', "<C-l>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>")
Kmap('n', "<C-\\>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<cr>")
--Kmap('n', "<C-Space>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<cr>", opts)
--
-- Language-specific binds
local fileTypeBindings = {
    {   pattern = { "c", "cpp", "ocaml" },
        binds = {
            { keys = "<leader>gr",
              cmd  = ":!make run<cr>"},
            { keys = "<leader>gt",
              cmd  = ":!make test<cr>"},
            { keys = "<leader>gb",
              cmd  = ":!make<cr>"}
        }
    },
    {   pattern = { "c", "cpp", "javascript" },
        binds = {
            { keys = "<leader>gf",
              cmd  = ":!ClangFormat<cr>" }
        }
    },
    {   pattern = { "haskell" },
        binds = {
            { keys = "<leader>gr",
              cmd  = ":!stack run<cr>" },
            { keys = "<leader>gt",
              cmd  = ":!stack test<cr>" },
            { keys = "<leader>gb",
              cmd  = ":!stack build<cr>" },
            { keys = "<leader>ge",
              cmd  = ":!stack %" },
            { keys = "<leader>t",
              cmd  = ":!GhcModType<cr>" }
        }
    },
    {   pattern = { "rust" },
        binds = {
            { keys = "<leader>gr",
              cmd  = ":Cargo run<cr>" },
            { keys = "<leader>gt",
              cmd  = ":Cargo test<cr>" },
            { keys = "<leader>gc",
              cmd  = ":Cargo check<cr>" },
            { keys = "<leader>gb",
              cmd  = ":Cargo build<cr>" },
            { keys = "<leader>gB",
              cmd  = ":Cargo build --release<cr>" }
        }
    },
    {   pattern = { "go" },
        binds = {
            { keys = "<leader>gr",
              cmd  = ":GoRun<cr>" },
            { keys = "<leader>gt",
              cmd  = ":GoTest<cr>" },
            { keys = "<leader>gb",
              cmd  = ":GoBuild<cr>" },
            { keys = "<leader>gf",
              cmd  = ":!cd %:p:h && go test && cd -<cr>" },
            { keys = "<leader>t",
              cmd  = ":GoInfo<cr>" },
        }
    }
}

for _, lang in pairs(fileTypeBindings) do
    for _, block in pairs(lang.binds) do
        vim.api.nvim_create_autocmd("FileType", {
            pattern = lang.pattern,
            callback = function()
                Kmap('n', block.keys, block.cmd, {noremap = true})
            end
        })
    end
end

--if has('macunix')
--    autocmd FileType python nnoremap <buffer><leader>rr :!python3 %<cr>
--    autocmd FileType python nnoremap <buffer><leader>rt :!python3 -m pytest -s %<cr>
--else
--    autocmd FileType python nnoremap <buffer><leader>rr :!python %<cr>
--    autocmd FileType python nnoremap <buffer><leader>rt :!python -m pytest -s %<cr>
--endif
--autocmd FileType python nnoremap <buffer><leader>rl :!pylint %<cr>
--autocmd FileType python nnoremap <buffer><leader>rb :!/usr/bin/black %<cr>
--autocmd FileType rust let g:rustfmt_autosave = 1
--
--" vimux-golang
--autocmd FileType go nnoremap <buffer><leader>rt :wa<CR> :GolangTestCurrentPackage<CR>
--autocmd FileType go nnoremap <buffer><leader>rf :wa<CR> :GolangTestFocused<CR>
--
--autocmd FileType sh nnoremap <buffer><leader>rr :!./%<CR>

-- Easy access to configuration files and loading
local configFiles = {
    {k="<l>co", t="edit", p="~/.config/nvim/init.lua"},
    {k="<l>ck", t="edit", p="~/.config/nvim/lua/keymap.lua"},
    {k="<l>cp", t="edit", p="~/.config/nvim/lua/plugins.lua"},
    {k="<l>cl", t="edit", p="~/.config/nvim/lua/lsp.lua"},
    {k="<l>cc", t="source", p="~/.config/nvim/init.lua"},
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

