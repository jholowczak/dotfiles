local opt = vim.opt
local cmd = vim.cmd

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false

if vim.loop.os_uname().sysname == "Darwin" then
    opt.shell = "/usr/local/bin/bash"
else
    opt.shell = "/usr/bin/bash"
end
opt.timeoutlen = 2000
opt.shortmess = "at"
opt.ruler = true
opt.number = true
opt.autoindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoread = true
opt.expandtab = true
opt.fileformats = "unix,dos,mac"
opt.showmatch = true
opt.splitbelow = true
opt.splitright = true
opt.wildmenu = true
opt.wildmode = "list:longest,full"
opt.mouse = "a"
opt.backspace = "indent,eol,start"
opt.clipboard = "unnamedplus"
opt.background = "dark"
opt.background = "dark" -- or "light" for light mode
cmd([[colorscheme gruvbox]])
opt.colorcolumn = "0"
opt.termguicolors = true

opt.list = true
opt.listchars:append "space:⋅"
opt.listchars:append "eol:↴"

-- gitsigns coloring
vim.api.nvim_set_hl(0, "SignColumn", {bg = "NONE", ctermbg="NONE"})
