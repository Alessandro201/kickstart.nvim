-- R integration and completion through R.nvim's built-in language server.
vim.pack.add {
  { src = 'https://github.com/R-nvim/R.nvim' },
}

require('r').setup {
  R_args = { '--quiet', '--no-save' },
  }
