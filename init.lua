-- Auto-install Lazy.nvim if not installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic settings
vim.opt.clipboard = 'unnamedplus'
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '•', nbsp = '␣' }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.showmode = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.g.have_nerd_font = false
vim.opt.undofile = true
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- TIP: Disable arrow keys in normal mode
 vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
 vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
 vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Set leader key
vim.g.mapleader = " "

-- Key mappings
local opts = { noremap = true, silent = true }

-- Lazy.nvim Plugin Manager Setup
require('lazy').setup({
    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require('lualine').setup {
                options = { theme = 'tokyonight' }
            }
        end,
    },

    -- Git integration
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
        end,
    },

    -- Color scheme
    {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd([[colorscheme tokyonight]])
        end,
    },

    -- LazyGit integration
    "kdheepak/lazygit.nvim",

    -- Tmux navigation
    "christoomey/vim-tmux-navigator",

    -- NvimTree for file explorer
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('nvim-tree').setup()
        end,
    },

    -- Telescope for fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- Telescope Projects for project management
    {
        'nvim-telescope/telescope-project.nvim',
        config = function()
            require('telescope').load_extension('project')
        end,
    },

    -- Treesitter for Syntax Highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },

    -- Catppuccin theme
    { "catppuccin/nvim", name = "catppuccin" },
})

-- Plugin-specific keymaps
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>sf', ':Telescope find_files<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>sg', ':Telescope live_grep<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>sb', ':Telescope buffers<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>p', ':Telescope projects<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>lg', ':LazyGit<CR>', opts)
-- Tmux navigation
vim.g.tmux_navigator_no_mappings = 1
vim.keymap.set('n', '<C-h>', ':TmuxNavigateLeft<CR>', opts)
vim.keymap.set('n', '<C-l>', ':TmuxNavigateRight<CR>', opts)
vim.keymap.set('n', '<C-j>', ':TmuxNavigateDown<CR>', opts)
vim.keymap.set('n', '<C-k>', ':TmuxNavigateUp<CR>', opts)

-- Tab management
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>to', ':tabonly<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>tc', ':tabclose<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>tm', ':tabmove<CR>', opts)

-- Split window navigation
vim.api.nvim_set_keymap('n', '<leader>sv', ':vsp<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>sh', ':sp<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>sc', '<C-w>c', opts)
vim.api.nvim_set_keymap('n', '<leader>so', '<C-w>o', opts)
vim.api.nvim_set_keymap('n', '<leader>sr', '<C-w>r', opts)

-- Terminal
vim.api.nvim_set_keymap('n', '<leader>t', ':term<CR>', opts)

-- Vertical movements
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', opts)
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', opts)
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', opts)
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', opts)

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
  end,
})

-- (it works[test])
