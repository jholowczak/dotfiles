-- lsp configuration

require 'utils.keys'
-- for lsp support of configs
require('neodev').setup()

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

local pop = function(close)
    local tagstack = vim.fn.gettagstack()
    if vim.tbl_isempty(tagstack) then
        return
    end
end

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
      expandable_indicator = true,
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
  if client.server_capabilities.inlayHintProvider then
      vim.g.inlay_hints_visible = true
      vim.lsp.inlay_hint.enable(true, {bufnr = bufnr})
  end
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  Kmap('n', '<l><tab>', vim.lsp.buf.hover, { buffer = bufnr})
  Kmap('n', '<l>fj', vim.lsp.buf.definition, { buffer = bufnr})
  Kmap('n', '<l>fk', ':pop<cr>', { buffer = bufnr})
  Kmap('n', '<l>fl', vim.lsp.buf.references, { buffer = bufnr})
  Kmap('n', '<l>fr', vim.lsp.buf.rename, { buffer = bufnr})
  Kmap('n', '<l>fi', vim.lsp.buf.implementation, { buffer = bufnr})
  Kmap('n', '<l>fh', vim.lsp.buf.signature_help, { buffer = bufnr})
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

local default_c = require('cmp_nvim_lsp').default_capabilities()
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
    capabilities = default_c,
    on_attach = function(client, bufnr)
      -- Hover actions
      --vim.keymap.set("n", "<S-tab>", vim.lsp.buf.hover())
      local ha = function()
        vim.cmd.RustLsp({'hover', 'actions'})
      end
      Kmap("n", "<S-tab>", ha, { buffer = bufnr })
      -- Code action groups
      --vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      local ca = function()
          vim.cmd.RustLsp('codeAction')
      end
      Kmap("n", "<l>a", ca, { buffer = bufnr })
      my_on_attach(client, bufnr)
    end,
    default_settings = {
        ["rust-analyzer"] = {}
    },
  }
}
--vim.g.coq_settings = { limits = {completion_auto_timeout = 0.2 } }

-- custom filetypes
vim.filetype.add({
    filename = {
        ['devcontainer.json'] = 'jsonc',
    },
})
