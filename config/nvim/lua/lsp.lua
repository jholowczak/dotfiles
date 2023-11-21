-- lsp configuration

require 'utils.keys'
local lspconfig = require('lspconfig')
local navic = require('nvim-navic')

-- Automatically start coq
--vim.lsp.settings.Lua.diagnostics.globals = {"vim"}
vim.g.coq_settings = { auto_start = true }

local my_on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  Kmap('n', '<l><tab>', '<cmd>lua vim.lsp.buf.hover()<cr>', nil, bufnr)
  Kmap('n', '<l>fj', '<cmd>lua vim.lsp.buf.definition()<cr>', nil, bufnr)
  Kmap('n', '<l>fk', ':pop<cr>', nil, bufnr)
  Kmap('n', '<l>fl', '<cmd>lua vim.lsp.buf.references()<cr>', nil, bufnr)
  Kmap('n', '<l>fr', '<cmd>lua vim.lsp.buf.rename()<cr>', nil, bufnr)
  Kmap('n', '<l>fi', '<cmd>lua vim.lsp.buf.implementation()<cr>', nil, bufnr)
  Kmap('n', '<l>fh', '<cmd>lua vim.lsp.buf.signature_help()<cr>', nil, bufnr)
end

-- ignore rust-analyzer here as it will be setup by rust-tools
local servers = {
    clangd = {},
    gopls = {},
    terraformls = {},
    pylsp = {},
    zls = {},
    yamlls = {},
    hls = {},
    jsonls = {},
    jsonnet_ls = {},
    marksman = {},
    html = {},
    texlab = {},
    lua_ls = {}
}

for lsp, _ in pairs(servers) do
  lspconfig[lsp].setup(
      require('coq').lsp_ensure_capabilities({
        on_attach = my_on_attach,
        flags = {
          -- This will be the default in neovim 0.7+
          debounce_text_changes = 150,
        }
      })
  )
end

-- set up rust-analyzer
local rt = require('rust-tools')
rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<S-tab>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      --my_on_attach(_, bufnr)
    end,
  },
})
rt.inlay_hints.enable()
vim.g.coq_settings = { limits = {completion_auto_timeout = 0.2 } } 
