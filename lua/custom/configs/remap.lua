-- open folder tree map viewer
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Move selected lines up/down adjusting the indentations
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Append line below to end of current line
vim.keymap.set('n', 'J', 'mzJ`z')

-- When scrolling down/up by halfpage keep the cursor at mid screen.
-- Same when moving to next/prev result after a search
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- greatest remap ever, paste from buffer without losing it
vim.keymap.set('x', '<leader>p', 'P')

-- next greates remap ever, copy to system clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

-- Delete to void, without losing buffer
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

-- Delete character to void, without losing buffer
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('v', 'x', '"_x')

vim.keymap.set('n', '<leader>o', 'm`o<Esc>``')
vim.keymap.set('n', '<leader>O', 'm`O<Esc>``')

vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

-- Replace selected text. Ask confirmation (y\n) for each step or confirm all (a)
vim.keymap.set('v', '<C-r>', '"hy:%s/<C-r>h//gc<left><left><left>')

-- Replace current WHOLE word. Ask confirmation (y\n) for each step or confirm all (a)
vim.keymap.set('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left>]], { desc = 'Replace word under cursor' })
vim.keymap.set('v', '<leader>rw', [[:%s/\<<C-r>\>/<C-r>/gcI<Left><Left><Left>]], { desc = 'Replace selection under cursor' })

-- Remap write to also include :W
vim.api.nvim_create_user_command('W', 'w', {})


-- Make file executable
-- vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- z0…z9 to open folds to a certain level
for i = 0, 9 do
  vim.keymap.set('n', 'z' .. i, ':set fdl=' .. i .. '<CR>', { noremap = true, silent = false })
end
-- folds
vim.g.ip_skipfold = true

-- TOGGLE DISABLE/ENABLE LSP
vim.keymap.set('n', '<leader>td', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true })
