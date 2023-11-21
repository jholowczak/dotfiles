-- layout settings
--
-- airline
-- vim.g.airline.extensions.tabline.enabled = 1
-- vim.g.airline.extensions.tabline.show_buffers = 1
-- vim.g.airline_powerline_fonts = 1
-- vim.g.airline_theme = 'hybrid'
local navic = require('nvim-navic')
local function session_name()
  return require('possession.session').session_name or ''
end
local function navic_location()
	local none_display = " "
	if navic.is_available() then
		local l = navic.get_location()
		return (l ~= "") and l or none_display
	else
		return none_display
	end
end

require('lualine').setup {
  options = {
    theme = 'onedark',
    ignore_focus = {'NvimTree'},
    disabled_filetypes = {'NvimTree'}
  },
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {navic_location},
    lualine_x = {session_name},
    lualine_y = {},
    lualine_z = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename', "lsp_progress"},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  tabline = {
    lualine_a = {{"buffers", mode=2}},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {{"tabs", mode=2}},
  },
  extensions = {'nvim-tree', 'nvim-dap-ui'}
}

