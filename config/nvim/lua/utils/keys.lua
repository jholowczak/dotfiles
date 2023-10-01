function Kmap(mode, lhs, rhs, opts, buf)
  local lhs_e = string.gsub(lhs, '<l>', '<leader>')
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  if buf then
      vim.api.nvim_buf_set_keymap(buf, mode, lhs_e, rhs, options)
  else
      vim.api.nvim_set_keymap(mode, lhs_e, rhs, options)
  end
end

