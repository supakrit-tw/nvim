-- ==========================================================================
-- 1. INITIAL SETUP
-- ==========================================================================
-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- Set <space> as the leader key (Must happen BEFORE plugins load)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = false


-- ==========================================================================
-- 2. EDITOR OPTIONS
-- ==========================================================================
local opt = vim.opt

opt.number = true              -- Show line numbers
-- opt.relativenumber = true   -- Uncomment to use relative line numbers
opt.mouse = 'a'                -- Enable mouse mode
opt.showmode = false           -- Don't show mode in command line
opt.breakindent = true         -- Enable break indent
opt.undofile = true            -- Enable persistent undo
opt.ignorecase = true          -- Case-insensitive searching
opt.smartcase = true           -- Case-sensitive if capitals are in search
opt.signcolumn = 'yes'         -- Always show signcolumn
opt.updatetime = 250           -- Decrease update time
opt.timeoutlen = 300           -- Decrease mapped sequence wait time
opt.splitright = true          -- Open new vertical splits to the right
opt.splitbelow = true          -- Open new horizontal splits below
opt.list = true                -- Show invisible characters
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.inccommand = 'split'       -- Preview substitutions live
opt.cursorline = true          -- Highlight current line
opt.scrolloff = 10             -- Keep 10 lines above/below cursor
opt.confirm = true             -- Prompt to save before closing modified buffers

-- Schedule clipboard sync after `UiEnter` to improve startup time
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)


-- ==========================================================================
-- 3. BASIC KEYMAPS
-- ==========================================================================
local map = vim.keymap.set

-- Clear highlights on search when pressing <Esc>
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })


-- ==========================================================================
-- 4. PLUGINS & PLUGIN KEYMAPS
-- ==========================================================================
-- Example using lazy.nvim (Standard modern package manager)
-- Bootstrapping lazy.nvim (Installs it if it's missing)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath,
  })
end
opt.rtp:prepend(lazypath)

-- Load plugins
require('lazy').setup({
  {
    'echasnovski/mini.pick',
    version = false,
    config = function()
      require('mini.pick').setup()
      
      -- Set plugin-specific keymaps inside the config function
      -- This ensures they only load if the plugin loads successfully
      map('n', '<leader>ff', '<cmd>Pick files<CR>', { desc = 'Mini.pick files' })
      map('n', '<leader>fb', '<cmd>Pick buffers<CR>', { desc = 'Mini.pick buffers' })
    end
  },
})
