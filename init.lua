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
vim.opt.timeoutlen = 300

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Set leader key
vim.g.mapleader = " "

-- Lazy.nvim Plugin Manager Setup
require('lazy').setup({
    -- Your original plugins
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require('lualine').setup {
                options = { theme = 'tokyonight' }
            }
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
        end,
    },
    {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
    "kdheepak/lazygit.nvim",
    "christoomey/vim-tmux-navigator",
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('nvim-tree').setup()
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        'nvim-telescope/telescope-project.nvim',
        config = function()
            require('telescope').load_extension('project')
        end,
    },
    { "catppuccin/nvim", name = "catppuccin" },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
})

-- Plugin-specific keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<Leader>e', ':NvimTreeToggle<CR>', opts)
vim.keymap.set('n', '<Leader>sf', ':Telescope find_files<CR>', opts)
vim.keymap.set('n', '<Leader>sg', ':Telescope live_grep<CR>', opts)
vim.keymap.set('n', '<Leader>sb', ':Telescope buffers<CR>', opts)
vim.keymap.set('n', '<Leader>p', ':Telescope projects<CR>', opts)
vim.keymap.set('n', '<Leader>lg', ':LazyGit<CR>', opts)

-- Tmux navigation
vim.g.tmux_navigator_no_mappings = 1
vim.keymap.set('n', '<C-h>', ':TmuxNavigateLeft<CR>', opts)
vim.keymap.set('n', '<C-l>', ':TmuxNavigateRight<CR>', opts)
vim.keymap.set('n', '<C-j>', ':TmuxNavigateDown<CR>', opts)
vim.keymap.set('n', '<C-k>', ':TmuxNavigateUp<CR>', opts)

-- Tab management
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', opts)
vim.keymap.set('n', '<leader>to', ':tabonly<CR>', opts)
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', opts)
vim.keymap.set('n', '<leader>tm', ':tabmove<CR>', opts)

-- Split window navigation
vim.keymap.set('n', '<leader>sv', ':vsp<CR>', opts)
vim.keymap.set('n', '<leader>sh', ':sp<CR>', opts)
vim.keymap.set('n', '<leader>sc', '<C-w>c', opts)
vim.keymap.set('n', '<leader>so', '<C-w>o', opts)
vim.keymap.set('n', '<leader>sr', '<C-w>r', opts)

-- Terminal
vim.keymap.set('n', '<leader>t', ':term<CR>', opts)

-- Vertical movements
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
  end,
})

-- Treesitter configuration
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

