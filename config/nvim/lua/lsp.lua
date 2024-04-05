-- lsp configuration

require 'utils.keys'
local lspconfig = require('lspconfig')
local navic = require('nvim-navic')

require("mason").setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})
require("mason-lspconfig").setup()

-- Completion Plugin Setup
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})


---- Automatically start coq
----vim.lsp.settings.Lua.diagnostics.globals = {"vim"}
--vim.g.coq_settings = { auto_start = true }
--
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

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

local default_c = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
for lsp, _ in pairs(servers) do
  lspconfig[lsp].setup{
    on_attach = my_on_attach,
    capabilities = default_c,
  }
end

require('go').setup({
    lsp_cfg = {
        on_attach = function(c, b)
            my_on_attach(c, b)
        end,
        capabilities = default_c
    }
})

-- set up rust-analyzer
vim.g.rustaceanvim = {
  server = {
    on_attach = function(client, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<S-tab>", vim.lsp.buf.hover())
      -- Code action groups
      --vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      my_on_attach(client, bufnr)
    end,
    settings = {
        ["rust-analyzer"] = {}
    },
  }
}
--vim.g.coq_settings = { limits = {completion_auto_timeout = 0.2 } }
