-- Set leader key
vim.g.mapleader = ' '

-- Install lazy.nvim if not present
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim with plugins
require('lazy').setup({
  -- Plugin list
  {
    'kdheepak/lazygit.nvim',
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" } },
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
  },
  {
    'ThePrimeagen/vim-be-good',
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
        defaults = {},
      })
      require('telescope').load_extension('fzf')

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        })
      end, { desc = '[S]earch [/] in Open Files' })
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files({ cwd = vim.fn.stdpath('config') })
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable('make') == 1
    end,
  },
  {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')
      dashboard.section.header.val = {
        [[  _ __   ___  _____   __ __ __ __   ]],
        [[ | '_ \ / _ \/ _ \ \ / / | '_ ` _ \ ]],
        [[ | | | |  __/ (_) \ V /| | | | | | |]],
        [[ |_| |_|\___|\___/ \_/ |_|_| |_| |_|]],
      }
      dashboard.section.buttons.val = {
        dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
        dashboard.button("r", "  Recently opened files", ":Telescope oldfiles<CR>"),
        dashboard.button("s", "  Settings", ":e $MYVIMRC<CR>"),
        dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
      }
      alpha.setup(dashboard.opts)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'c', 'cpp', 'python', 'lua' },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<C-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<C-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<C-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<C-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<C-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  -- Removed LSP-related configuration
  -- {
  --   'neovim/nvim-lspconfig',
  --   config = function()
  --     local lspconfig = require('lspconfig')
  --     lspconfig.clangd.setup({})
  --     lspconfig.pyright.setup({})
  --   end,
  -- },
  -- {
  --   'hrsh7th/nvim-cmp',
  --   dependencies = {
  --     'hrsh7th/cmp-nvim-lsp',
  --     'hrsh7th/cmp-buffer',
  --     'hrsh7th/cmp-path',
  --     'hrsh7th/cmp-cmdline',
  --     'L3MON4D3/LuaSnip',
  --     'saadparwaiz1/cmp_luasnip',
  --   },
  --   config = function()
  --     local cmp = require('cmp')
  --     cmp.setup({
  --       snippet = {
  --         expand = function(args)
  --           require('luasnip').lsp_expand(args.body)
  --         end,
  --       },
  --       mapping = {
  --         ['<C-p>'] = cmp.mapping.select_prev_item(),
  --         ['<C-n>'] = cmp.mapping.select_next_item(),
  --         ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  --         ['<C-Space>'] = cmp.mapping.complete(),
  --       },
  --       sources = cmp.config.sources({
  --         { name = 'nvim_lsp' },
  --         { name = 'luasnip' },
  --       }, {
  --         { name = 'buffer' },
  --         { name = 'path' },
  --       }),
  --     })
  --     cmp.setup.cmdline(':', {
  --       sources = cmp.config.sources({
  --         { name = 'path' },
  --       }, {
  --         { name = 'cmdline' },
  --       }),
  --     })
  --     cmp.setup.cmdline('/', {
  --       sources = { { name = 'buffer' } },
  --     })
  --   end,
  -- },
})

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

-- Vertical movements
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { noremap = true })
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true })

-- Highlight yanked text
vim.api.nvim_set_hl(0, 'YankHighlight', { ctermbg = 'yellow', bg = 'yellow' })
vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'YankHighlight',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'YankHighlight', timeout = 200 })
  end,
})

-- Save file shortcuts
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true })

--will use noetree
vim.api.nvim_set_keymap('n', '<leader>n', ':Neotree reveal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>c', ':Neotree close<CR>', { noremap = true, silent = true })

-- Tab management
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>to', ':tabonly<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tc', ':tabclose<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tm', ':tabmove<CR>', { noremap = true })

-- Split window navigation
vim.api.nvim_set_keymap('n', '<leader>sv', ':vsp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>sh', ':sp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>sc', '<C-w>c', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>so', '<C-w>o', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>sr', '<C-w>r', { noremap = true })
vim.cmd('colorscheme catppuccin')
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })
