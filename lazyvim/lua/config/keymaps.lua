-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- For conciseness
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", opts)

-- save file without auto-formatting
-- vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

-- quit file
vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", opts)

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Buffers
-- vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
-- vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
-- vim.keymap.set("n", "<leader>x", ":Bdelete!<CR>", opts) -- close buffer
-- vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts) -- new buffer

vim.keymap.set("n", "<S-M-l>", ":BufferLineMoveNext<CR>", opts)
vim.keymap.set("n", "<S-M-h>", ":BufferLineMovePrev<CR>", opts)

-- Window management
-- vim.keymap.set('n', '<leader>v', '<C-w>v', opts)      -- split window vertically
-- vim.keymap.set('n', '<leader>h', '<C-w>s', opts)      -- split window horizontally
-- vim.keymap.set('n', '<leader>se', '<C-w>=', opts)     -- make split windows equal width & height
-- vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- Navigate between splits
-- vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
-- vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
-- vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
-- vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)

-- Tabs
-- vim.keymap.set("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
-- vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
-- vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts) --  go to next tab
-- vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts) --  go to previous tab

-- Toggle line wrapping
-- vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move text up and down
-- vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", opts)
-- vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", opts)
-- vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", opts)
-- vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Toggle diagnostics
-- local diagnostics_active = true
--
-- vim.keymap.set('n', '<leader>do', function()
--   diagnostics_active = not diagnostics_active
--
--   if diagnostics_active then
--     vim.diagnostic.enable(0)
--   else
--     vim.diagnostic.disable(0)
--   end
-- end)
--
-- -- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
--
-- vim.keymap.set('n', '<C-g>', ':Gitsigns<CR>', opts)
-- vim.keymap.set('v', '<C-g>', ':Gitsigns<CR>', opts)
