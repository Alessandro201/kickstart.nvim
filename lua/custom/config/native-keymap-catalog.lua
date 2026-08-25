-- Add description for the default nvim key mappings

local M = {}

M.native = {
  -- Argument list
  { '[a', desc = 'Previous file in argument list' },
  { ']a', desc = 'Next file in argument list' },
  { '[A', desc = 'First file in argument list' },
  { ']A', desc = 'Last file in argument list' },

  -- Buffers
  { '[b', desc = 'Previous buffer' },
  { ']b', desc = 'Next buffer' },
  { '[B', desc = 'First buffer' },
  { ']B', desc = 'Last buffer' },

  -- Quickfix list
  { '[q', desc = 'Previous quickfix entry' },
  { ']q', desc = 'Next quickfix entry' },
  { '[Q', desc = 'First quickfix entry' },
  { ']Q', desc = 'Last quickfix entry' },

  -- Location list
  { '[l', desc = 'Previous location-list entry' },
  { ']l', desc = 'Next location-list entry' },
  { '[L', desc = 'First location-list entry' },
  { ']L', desc = 'Last location-list entry' },

  -- Tag matches
  { '[t', desc = 'Previous tag match' },
  { ']t', desc = 'Next tag match' },
  { '[T', desc = 'First tag match' },
  { ']T', desc = 'Last tag match' },

  -- Sections
  { '[[', desc = 'Previous section start' },
  { ']]', desc = 'Next section start' },
  { '[]', desc = 'Previous section end' },
  { '][', desc = 'Next section end' },

  -- Method and brace-based structure
  { '[m', desc = 'Previous method start' },
  { ']m', desc = 'Next method start' },
  { '[M', desc = 'Previous method end' },
  { ']M', desc = 'Next method end' },

  -- Unmatched delimiters
  { '[(', desc = 'Previous unmatched opening parenthesis' },
  { '])', desc = 'Next unmatched closing parenthesis' },
  { '[{', desc = 'Previous unmatched opening brace' },
  { ']}', desc = 'Next unmatched closing brace' },

  -- Spelling
  { '[s', desc = 'Previous spelling error' },
  { ']s', desc = 'Next spelling error' },
  { '[S', desc = 'Previous severe spelling error' },
  { ']S', desc = 'Next severe spelling error' },

  -- Jump list
  { '<C-o>', desc = 'Previous jump location' },
  { '<C-i>', desc = 'Next jump location' },

  -- Character search repetition like with f/F/t/T
  { ';', desc = 'Repeat latest search with f/F/t/T' },
  { ',', desc = 'Repeat latest search backwards with f/F/t/T' },

  -- Search repetition
  { 'n', desc = 'Repeat latest search' },
  { 'N', desc = 'Repeat latest search backwards' },

  -- Marks
  { "'.", desc = 'Jump to last changed line' },
  { '`.', desc = 'Jump to last changed position' },
  { "'[", desc = 'Jump to start of last changed or yanked text' },
  { "']", desc = 'Jump to end of last changed or yanked text' },
  { '`[', desc = 'Jump exactly to start of last changed or yanked text' },
  { '`]', desc = 'Jump exactly to end of last changed or yanked text' },
}

-- Telescope can show mappings with `<leader>sk`, but only if they are defined with vim.keymap.set().
-- Thus, it doesn't display the description defined above for native mappings.
-- The code below will merge the two mappings letting telescope show them all.
function M.telescope()
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values

  local entries = {}
  local seen = {}

  local function add(mode, lhs, desc)
    if not lhs or lhs == '' then return end

    local id = mode .. '\0' .. lhs

    if seen[id] then
      if desc and desc ~= '' then
        seen[id].description = desc
        seen[id].ordinal = mode .. ' ' .. lhs .. ' ' .. desc
        seen[id].display = string.format('%-3s %-20s %s', mode, lhs, desc)
      end

      return
    end

    desc = desc or ''

    local entry = {
      mode = mode,
      lhs = lhs,
      description = desc,
      ordinal = mode .. ' ' .. lhs .. ' ' .. desc,
      display = string.format('%-3s %-20s %s', mode, lhs, desc ~= '' and desc or '(no description)'),
    }

    seen[id] = entry
    entries[#entries + 1] = entry
  end

  for _, mode in ipairs { 'n', 'x', 's', 'o', 'i', 'c', 't' } do
    for _, mapping in ipairs(vim.api.nvim_get_keymap(mode)) do
      add(mode, mapping.lhs, mapping.desc)
    end

    for _, mapping in ipairs(vim.api.nvim_buf_get_keymap(0, mode)) do
      add(mode, mapping.lhs, mapping.desc)
    end
  end

  for _, mapping in ipairs(M.native) do
    local modes = type(mapping.mode) == 'table' and mapping.mode or { mapping.mode or 'n' }

    for _, mode in ipairs(modes) do
      add(mode, mapping[1], mapping.desc)
    end
  end

  table.sort(entries, function(a, b)
    if a.mode == b.mode then return a.lhs < b.lhs end

    return a.mode < b.mode
  end)

  pickers
    .new({}, {
      prompt_title = 'Keymaps',
      finder = finders.new_table {
        results = entries,
        entry_maker = function(entry) return entry end,
      },
      sorter = conf.generic_sorter {},
    })
    :find()
end

return M
