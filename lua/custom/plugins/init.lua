-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- Iterate over all Lua files in the plugins directory and load them
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins')
for file_name, type in vim.fs.dir(plugins_dir, { follow = true }) do
  if (type == 'file' or type == 'link') and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local module = file_name:gsub('%.lua$', '')
    require('custom.plugins.' .. module)
  end
end

-- Add plugins with nvim.pack
vim.pack.add {
  -- undotree
  { src = 'https://github.com/mbbill/undotree' },

  -- diffview
  { src = 'https://github.com/sindrets/diffview.nvim' },

  -- cargo-expand
  { src = 'https://github.com/johnsaigle/cargo-expand.nvim' },

  -- colorblocks
  { src = 'https://github.com/Bishop-Fox/colorblocks.nvim' },

  { src = 'https://github.com/rafikdraoui/jj-diffconflicts' },
}

-- Plugin configurations (called after vim.pack.add so the plugins are reachable)

-- undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle [U]ndooTree' })

-- diffview
require('diffview').setup {}
vim.keymap.set({ 'n', 'v' }, '<leader>vo', '<Cmd>DiffviewOpen<CR>', { desc = 'Show repo [D]iff against index' })
vim.keymap.set('n', '<leader>vh', '<Cmd>DiffviewFileHistory<CR>', { desc = 'Show repo [D]iff history' })
vim.keymap.set('v', '<leader>vh', "<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>", { desc = 'Show [D]iff history for current selection' })

-- cargo-expand
require('cargo-expand').setup()

-- colorblocks
require('colorblocks').setup {
  symbol = '███████',
  virt_text_pos = 'eol', -- Position of virtual text: "eol", "overlay", etc.
  mode = 'fg', -- Whether to apply the hex color to the foreground or background
  show_hex = false, -- Show the hex value next to the block
  -- section = { "S", "  ", "The color is: ", "H" },
  section = { ' ', 'S' }, -- Ordered segments: S = symbol, H = hex, strings = literals
  -- filetypes = { "lua", "css", "*" },
}

-- enable on every buffer when it's loaded/entered
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'BufEnter' }, {
  pattern = '*',
  callback = function() vim.cmd 'ColorBlocksEnable' end,
})
