-- layout settings
--
-- airline
-- vim.g.airline.extensions.tabline.enabled = 1
-- vim.g.airline.extensions.tabline.show_buffers = 1
-- vim.g.airline_powerline_fonts = 1
-- vim.g.airline_theme = 'hybrid'
local navic = require('nvim-navic')
local function session_name()
  return require('possession.session').get_session_name() or ''
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

local function arduino_status()
  if vim.bo.filetype ~= "arduino" then
    return ""
  end
  local port = vim.fn["arduino#GetPort"]()
  local line = string.format("[%s]", vim.g.arduino_board)
  if vim.g.arduino_programmer ~= "" then
    line = line .. string.format(" [%s]", vim.g.arduino_programmer)
  end
  if port ~= 0 then
    line = line .. string.format(" (%s:%s)", port, vim.g.arduino_serial_baud)
  end
  return line
end

local function currentContainer()
    return vim.g.currentContainer or ""
end

require('lualine').setup {
  options = {
    theme = 'onedark',
    ignore_focus = {'NvimTree'},
    disabled_filetypes = {
        'NvimTree', 'SymbolsSidebar',
        "dapui_watches", "dapui_breakpoints",
        "dapui_scopes", "dapui_console",
        "dapui_stacks", "dap-repl"
    }
  },
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {navic_location},
    lualine_x = {session_name},
    lualine_y = {{'filename', path=1}},
    lualine_z = {arduino_status}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'lsp_progress'},
    lualine_x = {currentContainer, 'encoding', 'fileformat', 'filetype'},
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

