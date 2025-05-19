-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle [U]ndooTree' })
    end,
  },

  {
    'm4xshen/hardtime.nvim',
    lazy = false,
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
  },

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'sindrets/diffview.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'lewis6991/gitsigns.nvim',
    },
    config = true,
    keys = {
      { '<leader>vo', '<Cmd>DiffviewOpen<CR>', mode = { 'n', 'v' }, desc = 'Show repo [D]iff against index' },
      { '<leader>vh', '<Cmd>DiffvieFileHistory<CR>', mode = { 'n' }, { desc = 'Show repo [D]iff history' } },
      { '<leader>vh', "<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>", mode = { 'v' }, { desc = 'Show [D]iff history for current selection' } },
    },
    opts = {},
  },
}
