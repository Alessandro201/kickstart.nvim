vim.filetype.add { extension = { nf = 'groovy' } }
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'html',
  callback = function()
    vim.opt.syntax = 'html.jinja'
  end,
})
