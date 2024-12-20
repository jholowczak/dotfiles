-- Tree-sitter configuration
require'nvim-treesitter.configs'.setup { modules = { "highlight" },
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'}, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
  },
  ident = { enable = true },
  rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
  },
  auto_install = false,
  sync_install = false,
  ignore_install = {},
  ensure_installed = {'go', 'gomod', 'html', 'latex', 'rust', 'c', 'python',
    'toml', 'lua', 'json', 'jsonnet', 'jsonc', 'v', 'yaml', 'r', 'regex', 'sql', 'zig',
    'javascript', 'make', 'hcl', 'haskell', 'diff', 'cpp', 'css',
    'bash', 'fish', 'dockerfile', 'nix', 'gitignore', 'markdown',
    'ocaml', 'arduino', 'norg'}, -- Or run :TSUpdate org
}
