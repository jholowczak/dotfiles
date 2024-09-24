require 'plugins'
require 'tmux'
require 'opts'
require 'treesitter'
require 'lsp'
require 'keymap'
require 'layout'
require 'ts'
require 'test'

-- required for project.nvim to work with nvim-tree
require("nvim-tree").setup({
  -- sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
  actions = {
    open_file = {
      quit_on_open = true
    }
  }
})

-- rust specific configs
vim.g.rust_recommended_style = 1
vim.g.rustfmt_autosave = 1

-- clipboard workaround 
--if os.getenv "SSH_CLIENT" ~= nil or os.getenv "SSH_TTY" ~= nil then
--    local function my_paste(_)
--        return function(_)
--            local content = vim.fn.getreg '"'
--            return vim.split(content, "\n")
--        end
--    end
--
--    vim.g.clipboard = {
--        name = "OSC 52",
--        copy = {
--            ["+"] = require("vim.ui.clipboard.osc52").copy "+",
--            ["*"] = require("vim.ui.clipboard.osc52").copy "*",
--        },
--        paste = {
--            ["+"] = my_paste "+",
--            ["*"] = my_paste "*",
--        },
--    }
--end
