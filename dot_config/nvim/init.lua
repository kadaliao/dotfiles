-- Based on kickstart.nvim (https://github.com/nvim-lua/kickstart.nvim)
-- Customized with personal preferences from nvim.bak

-- Set <space> as the leader key (must happen before plugins load)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false

-- Don't auto-sync clipboard; use explicit <leader>y/<leader>p instead
-- vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.confirm = true

-- Personal preferences from old config
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.linebreak = true
vim.o.scrolloff = 4
vim.o.sidescrolloff = 8
vim.o.hlsearch = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.conceallevel = 0
vim.o.pumheight = 10
vim.o.showtabline = 2
vim.opt.termguicolors = true
vim.opt.shortmess:append 'c'
vim.opt.iskeyword:append '-'
vim.opt.formatoptions:remove { 'c', 'r', 'o' }

-- Prevent LSP from overwriting treesitter color settings
vim.hl.priorities.semantic_tokens = 95

-- [[ Basic Keymaps ]]

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic Config
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  virtual_text = true,
  virtual_lines = false,
  jump = { float = true },
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation with CTRL+<hjkl>
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Custom Keymaps ]]
local opts = { noremap = true, silent = true }

-- Insert mode: jk/kj to escape
vim.keymap.set('i', 'jk', '<ESC>', opts)
vim.keymap.set('i', 'kj', '<ESC>', opts)

-- Save and quit
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', opts)
vim.keymap.set('n', '<C-q>', '<cmd>q<CR>', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- System clipboard (explicit, since we don't auto-sync)
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { noremap = true, desc = 'Copy to system clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { noremap = true, desc = 'Copy line to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { noremap = true, desc = 'Paste from system clipboard' })
vim.keymap.set('n', '<leader>P', '"+P', { noremap = true, desc = 'Paste before from system clipboard' })

-- Whole document operations
vim.keymap.set('n', 'vae', 'ggVG', opts)
vim.keymap.set('n', 'dae', 'ggdG', opts)
vim.keymap.set('n', 'cae', 'ggdGi', opts)
vim.keymap.set('v', 'vae', '<Esc>ggVG', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Keep last yanked when pasting in visual mode
vim.keymap.set('v', 'p', '"_dP', opts)

-- Buffer navigation (works with bufferline)
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>x', ':bdelete!<CR>', { noremap = true, silent = true, desc = 'Close buffer' })
vim.keymap.set('n', '<leader>b', '<cmd>enew<CR>', { noremap = true, silent = true, desc = 'New buffer' })

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', { noremap = true, silent = true, desc = 'Split vertical' })
vim.keymap.set('n', '<leader>-', '<C-w>s', { noremap = true, silent = true, desc = 'Split horizontal' })
vim.keymap.set('n', '<leader>se', '<C-w>=', { noremap = true, silent = true, desc = 'Equalize splits' })

-- [[ Basic Autocommands ]]

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- [[ Install lazy.nvim ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup({

  -- Automatic indentation detection
  { 'NMAC427/guess-indent.nvim', opts = {} },

  -- Git signs in the gutter
  {
    'lewis6991/gitsigns.nvim',
    ---@module 'gitsigns'
    ---@type Gitsigns.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      signs = {
        add = { text = '+' }, ---@diagnostic disable-line: missing-fields
        change = { text = '~' }, ---@diagnostic disable-line: missing-fields
        delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
        topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
        changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
      },
    },
  },

  -- Which-key: show pending keybinds
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    ---@module 'which-key'
    ---@type wk.Opts
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { 'gr', group = 'LSP Actions', mode = { 'n' } },
      },
    },
  },

  -- Telescope: fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    enabled = true,
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function() return vim.fn.executable 'make' == 1 end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-k>'] = require('telescope.actions').move_selection_previous,
              ['<C-j>'] = require('telescope.actions').move_selection_next,
              ['<C-l>'] = require('telescope.actions').select_default,
            },
          },
        },
        pickers = {
          find_files = {
            file_ignore_patterns = { 'node_modules', '.git', '.venv', '__pycache__' },
            hidden = true,
          },
        },
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown() },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- LSP-specific telescope keymaps (set on LspAttach)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
        callback = function(event)
          local buf = event.buf
          vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })
          vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })
          vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })
          vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })
          vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })
          vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
        end,
      })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Highlight references under cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Toggle inlay hints
          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      ---@type table<string, vim.lsp.Config>
      local servers = {
        -- Lua
        lua_ls = {
          on_init = function(client)
            if client.workspace_folders then
              local path = client.workspace_folders[1].name
              if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
            end
            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
              runtime = { version = 'LuaJIT', path = { 'lua/?.lua', 'lua/?/init.lua' } },
              workspace = {
                checkThirdParty = false,
                library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), { '${3rd}/luv/library', '${3rd}/busted/library' }),
              },
            })
          end,
          settings = { Lua = {} },
        },

        -- Rust
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              check = { command = 'clippy' },
              cargo = { allFeatures = true },
            },
          },
        },

        -- Python
        ruff = {},
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                mccabe = { enabled = false },
                pylsp_mypy = { enabled = false },
                pylsp_black = { enabled = false },
                pylsp_isort = { enabled = false },
              },
            },
          },
        },

        -- TypeScript/JavaScript
        ts_ls = {},

        -- Web
        html = { filetypes = { 'html', 'twig', 'hbs' } },
        cssls = {},
        tailwindcss = {},

        -- Data/Config
        jsonls = {},
        yamlls = {},
        sqlls = {},

        -- DevOps
        dockerls = {},
        terraformls = {},

        -- Go
        gopls = {},
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'prettier',
        'ruff',
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      for name, server in pairs(servers) do
        vim.lsp.config(name, server)
        vim.lsp.enable(name)
      end
    end,
  },

  -- Autoformat with conform
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function() require('conform').format { async = true, lsp_format = 'fallback' } end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return { timeout_ms = 500, lsp_format = 'fallback' }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff_format' },
        rust = { 'rustfmt' },
        javascript = { 'prettier', stop_after_first = true },
        typescript = { 'prettier', stop_after_first = true },
        javascriptreact = { 'prettier', stop_after_first = true },
        typescriptreact = { 'prettier', stop_after_first = true },
        html = { 'prettier' },
        css = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
      },
    },
  },

  -- Autocompletion with blink.cmp
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
          },
        },
        opts = {},
      },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },
      appearance = { nerd_font_variant = 'mono' },
      completion = { documentation = { auto_show = true, auto_show_delay_ms = 300 } },
      sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'lua' },
      signature = { enabled = true },
    },
  },

  -- Colorscheme: tokyonight
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = { comments = { italic = false } },
      }
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    ---@module 'todo-comments'
    ---@type TodoOptions
    ---@diagnostic disable-next-line: missing-fields
    opts = { signs = false },
  },

  -- Mini.nvim: surround, textobjects, statusline
  {
    'nvim-mini/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function() return '%2l:%-2v' end
    end,
  },

  -- Treesitter: syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    config = function()
      local parsers = {
        'bash', 'c', 'css', 'diff', 'dockerfile', 'go', 'html', 'javascript',
        'json', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'python',
        'query', 'rust', 'sql', 'toml', 'tsx', 'typescript', 'vim', 'vimdoc', 'yaml',
      }
      require('nvim-treesitter').install(parsers)

      ---@param buf integer
      ---@param language string
      local function treesitter_try_attach(buf, language)
        if not vim.treesitter.language.add(language) then return end
        vim.treesitter.start(buf, language)
        local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
        if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
      end

      local available_parsers = require('nvim-treesitter').get_available()
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf, filetype = args.buf, args.match
          local language = vim.treesitter.language.get_lang(filetype)
          if not language then return end
          local installed_parsers = require('nvim-treesitter').get_installed 'parsers'
          if vim.tbl_contains(installed_parsers, language) then
            treesitter_try_attach(buf, language)
          elseif vim.tbl_contains(available_parsers, language) then
            require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
          else
            treesitter_try_attach(buf, language)
          end
        end,
      })
    end,
  },

  -- =====================================================================
  -- Extra plugins (not in kickstart defaults)
  -- =====================================================================

  -- Neo-tree: file explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
      { '<leader>e', ':Neotree toggle position=left<CR>', desc = 'Toggle file explorer', silent = true },
      { '\\', ':Neotree reveal<CR>', desc = 'Reveal current file in explorer', silent = true },
    },
    opts = {
      close_if_last_window = false,
      popup_border_style = 'rounded',
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            '.DS_Store',
            'thumbs.db',
            'node_modules',
            '__pycache__',
            '.git',
            '.venv',
          },
        },
        follow_current_file = { enabled = false },
        hijack_netrw_behavior = 'open_default',
        use_libuv_file_watcher = false,
      },
      window = {
        position = 'left',
        width = 40,
        mappings = {
          ['l'] = 'open',
          ['h'] = 'close_node',
        },
      },
    },
  },

  -- Bufferline: buffer tabs at the top
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VimEnter',
    opts = {
      options = {
        mode = 'buffers',
        diagnostics = 'nvim_lsp',
        close_command = 'bdelete! %d',
        buffer_close_icon = '✗',
        close_icon = '✗',
        modified_icon = '●',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 30,
        tab_size = 21,
        color_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        separator_style = 'thin',
        always_show_bufferline = true,
        sort_by = 'insert_at_end',
        offsets = {
          { filetype = 'neo-tree', text = 'File Explorer', text_align = 'center', separator = true },
        },
      },
    },
  },

  -- Alpha: dashboard / start screen
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VimEnter',
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.startify'

      dashboard.section.header.val = {
        [[                                                    ]],
        [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
        [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
        [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
        [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
        [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
        [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
        [[                                                    ]],
      }

      alpha.setup(dashboard.opts)
    end,
  },

  -- LeetCode
  {
    'kawre/leetcode.nvim',
    lazy = true,
    cmd = { 'Leet' },
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      local lang = 'python3'
      local lang_map = { python3 = 'python', python = 'python' }
      local dir_name = lang_map[lang] or lang

      require('leetcode').setup {
        lang = lang,
        cn = { enabled = true, translator = true, translate_problems = true },
        image_support = false,
        storage = {
          home = vim.fn.expand('~/workspace/leetcode/' .. dir_name),
          cache = vim.fn.stdpath 'cache' .. '/leetcode',
        },
        file_name_format = '${id}-${snake_case_title}.${ext}',
      }
    end,
  },

}, { ---@diagnostic disable-line: missing-fields
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
