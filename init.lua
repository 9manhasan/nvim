-- Set leader key
vim.g.mapleader = ' '

--vertical movements
vim.api.nvim_set_keymap('n','<C-d>', '<C-d>zz', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { noremap = true })
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true })

-- Define a highlight group for yanked text
vim.api.nvim_set_hl(0, 'YankHighlight', { ctermbg = 'yellow', bg = 'yellow' })

-- Create an autocmd group
vim.api.nvim_create_augroup('YankHighlight', { clear = true })

-- Set up an autocmd to highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'YankHighlight',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'YankHighlight', timeout = 200 })
  end,
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

-- Key mappings for arrow keys
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Key mappings for tabs and splits
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>to', ':tabonly<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tc', ':tabclose<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>th', ':tabprev<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tl', ':tabnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>v', ':vsp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>s', ':sp<CR>', { noremap = true })

-- Key mappings for window navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })

-- Keybinding to toggle NvimTree
vim.api.nvim_set_keymap('n', '<leader>n', ':Neotree filesystem reveal left<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<leader>c',':Neotree filesystem close<CR>',{})

-- Increment and decrement number under cursor
vim.api.nvim_set_keymap('n', '+', '<C-a>', { noremap = true })
vim.api.nvim_set_keymap('n', '-', '<C-x>', { noremap = true })

-- Lazy.nvim setup
local lazypath = vim.fn.stdpath('config') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  -- LazyGit plugin
  {
    'kdheepak/lazygit.nvim',
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" } },
  },
  -- Catppuccin colorscheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
  },
    {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
},
  -- Telescope setup
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        defaults = {
          -- Default configuration for telescope goes here
        },
      }
      require('telescope').load_extension('fzf')

      local builtin = require('telescope.builtin')
      -- Key mappings for Telescope
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Fuzzy search in current buffer
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- Live grep in open files
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Search Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath('config') }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
  -- Telescope FZF native
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable('make') == 1
    end,
  },
  -- Alpha dashboard
  {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')
        dashboard.section.header.val = {
        [[                                                     ]],
        [[  _ __   ___  _____   __ __ __ __   ]],
        [[ | '_ \ / _ \/ _ \ \ / / | '_ ` _ \ ]],
        [[ | | | |  __/ (_) \ V /| | | | | | | ]],
        [[ |_| |_|\___|\___/ \_/ |_|_| |_| |_| ]],
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
  -- Treesitter setup
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "c", "cpp", "python", "lua"},
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      }
    end,
  },
  -- Tmux Navigator
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<C-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
    {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')

      -- C++ LSP
      lspconfig.clangd.setup{}

      -- Python LSP
      lspconfig.pyright.setup{}
    end
  },

  -- Completion plugin
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',  -- LSP source for nvim-cmp
      'hrsh7th/cmp-buffer',    -- Buffer source for nvim-cmp
      'hrsh7th/cmp-path',      -- Path source for nvim-cmp
      'hrsh7th/cmp-cmdline',   -- Cmdline source for nvim-cmp
      'L3MON4D3/LuaSnip',      -- Snippets plugin
      'saadparwaiz1/cmp_luasnip' -- Snippet source for nvim-cmp
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
      })

      -- Setup for command-line completion
      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        })
      })

      cmp.setup.cmdline('/', {
        sources = cmp.config.sources({
          { name = 'buffer' }
        })
      })
    end
  }
}

-- Set colorscheme and enable syntax highlighting
vim.cmd('colorscheme catppuccin')
vim.cmd('syntax enable')
vim.cmd('set splitbelow')
vim.cmd('set termguicolors')

-- Key mapping to toggle the terminal window
vim.api.nvim_set_keymap('n', '<leader>t', ':term<CR>', { noremap = true })

-- Undo settings
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
vim.opt.undofile = true

-- Key mappings for undo and redo
vim.api.nvim_set_keymap('n', 'u', ':undo<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-r>', ':redo<CR>', { noremap = true })

-- Set up key mappings for LSP commands
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', { noremap = true, silent = true })

