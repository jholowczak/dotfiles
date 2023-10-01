-- lsp configuration

require 'utils.keys'
local lspconfig = require('lspconfig')
local navic = require('nvim-navic')

-- Automatically start coq
local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  
  Kmap('n', '<leader>t', '<cmd>lua vim.lsp.buf.hover()<cr>', nil, bufnr)
  Kmap('n', '<leader>gg', '<cmd>lua vim.lsp.buf.definition()<cr>', nil, bufnr)
  Kmap('n', '<leader>gp', ':pop<cr>', nil, bufnr)
  Kmap('n', '<leader>gl', '<cmd>lua vim.lsp.buf.references()<cr>', nil, bufnr)
  Kmap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.rename()<cr>', nil, bufnr)
  Kmap('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', nil, bufnr)
  Kmap('n', '<leader>gh', '<cmd>lua vim.lsp.buf.signature_help()<cr>', nil, bufnr)
end

--vim.lsp.settings.Lua.diagnostics.globals = {"vim"}

vim.g.coq_settings = { auto_start = true }
local servers = { 'rust_analyzer', 'clangd', 'gopls', 'terraformls', 'pylsp', 'zls', 'yamlls',
    'hls', 'jsonls', 'jsonnet_ls', 'marksman', 'html', 'texlab', 'lua_ls'
    }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(
      require('coq').lsp_ensure_capabilities({
        on_attach = on_attach,
        flags = {
          -- This will be the default in neovim 0.7+
          debounce_text_changes = 150,
        }
      })
  )
end
