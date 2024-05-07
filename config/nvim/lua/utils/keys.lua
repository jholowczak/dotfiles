function Kmap(mode, lhs, rhs, opts)
  local lhs_e = string.gsub(lhs, '<l>', '<leader>')
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs_e, rhs, options)
end

