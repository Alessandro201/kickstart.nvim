vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'BufNewFile' }, {
  pattern = { '*.nf', '*.nextflow', 'nextflow.config' },
  command = 'set ft=groovy',
})
