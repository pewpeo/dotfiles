-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.wo.number = true -- line numbers (default: false)
vim.o.relativenumber = false -- relative line numbers (default: false)
vim.o.clipboard = "unnamedplus" -- sync clipboad with OS (default: '')
vim.o.wrap = false -- line wrap (default: true)
vim.o.linebreak = true -- split words (default: true)
vim.o.mouse = "a" -- mouse mode (default: '')
vim.o.ignorecase = true -- case insensitive searching UNLESS \C or capial in search (default: false)
vim.o.smartcase = true
vim.o.shiftwidth = 4 -- Number of spaces for each indentation
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.smartindent = true -- Automatically indent new lines
vim.o.softtabstop = 4 -- Number of spaces considered as tab for tab and backspace key
vim.o.hlsearch = true -- search highlighting
vim.o.incsearch = true -- incremental search
vim.opt.termguicolors = true

vim.g.lazyvim_prettier_needs_config = true
