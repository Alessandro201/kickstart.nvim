-- open folder tree map viewer
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open file explorer' })

-- Move selected lines up/down adjusting the indentations
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })

-- Append line below to end of current line
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join line below' })

-- When scrolling down/up by halfpage keep the cursor at mid screen.
-- Same when moving to next/prev result after a search
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll half-page down and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll half-page up and center' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result and center' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result and center' })

-- greatest remap ever, paste from buffer without losing it
vim.keymap.set('x', '<leader>p', 'P', { desc = 'Paste without replacing register' })

-- Paste from " buffer before the block selection. Useful when you want to paste something before the block selection
-- spanning multiple lines selected with C-v
vim.keymap.set('v', '<C-p>', 'I<C-r>"<Esc>', { desc = 'Paste from YANK (") buffer before the block selection' })

-- next greates remap ever, copy to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Yank line to system clipboard' })

-- Delete to void, without losing buffer
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'Delete without replacing register' })

-- Delete character to void, without losing buffer
vim.keymap.set({ 'n', 'v' }, 'x', '"_x')

-- Add line below/above without entering insert mode
vim.keymap.set('n', '<leader>o', 'm`o<Esc>``', { desc = 'Add blank line below' })
vim.keymap.set('n', '<leader>O', 'm`O<Esc>``', { desc = 'Add blank line above' })

vim.keymap.set('n', 'Q', '<nop>')

-- Removed as nvim 0.12 already defines mappings for moving between quickfix and location items
-- vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz', { desc = 'Next quickfix entry' })
-- vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz', { desc = 'Previous quickfix entry' })
-- vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz', { desc = 'Next location-list entry' })
-- vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz', { desc = 'Previous location-list entry' })

-- Replace selected text. Ask confirmation (y\n) for each step or confirm all (a)
vim.keymap.set('v', '<C-r>', '"hy:%s/<C-r>h/<C-r>h/gc<left><left><left>', { desc = 'Replace selection' })

-- Replace current WHOLE word. Ask confirmation (y\n) for each step or confirm all (a)
vim.keymap.set('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left>]], { desc = 'Replace word under cursor' })
vim.keymap.set('v', '<leader>rw', [[:%s/\<<C-r>\>/<C-r>/gcI<Left><Left><Left>]], { desc = 'Replace selection under cursor' })

-- Remap write to also include :W
vim.api.nvim_create_user_command('W', 'w', {})

-- TOGGLE DISABLE/ENABLE LSP
vim.keymap.set('n', '<leader>td', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, {
  silent = true,
  desc = '[T]oggle [D]iagnostics',
})
