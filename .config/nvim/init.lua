-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- vim.opt.laststatus = 3

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {"eandrju/cellular-automaton.nvim",
      config = function()
        vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")
      end,
    },
    {"EdenEast/nightfox.nvim"},
    {"OXY2DEV/markview.nvim",
      lazy = false,
      opts = {
        preview = {
          enable = false,
        },
      },
    },
    -- a function here would be nice 

    {"christoomey/vim-tmux-navigator"}, -- navigate across tmux splits
    {"nvim-lua/popup.nvim"},
    {"norcalli/nvim-colorizer.lua"}, -- color hex/rgb strings

    {"nvim-lualine/lualine.nvim",
      dependencies = {"nvim-tree/nvim-web-devicons"},
    },
    {"SmiteshP/nvim-navic",
      dependencies = {"neovim/nvim-lspconfig"},
    },

    {'stevearc/oil.nvim',
      config = function()
        require("oil").setup({
          keymaps = {
          },
          view_options = {
            show_hidden = true,
          },
        })
        vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
      end,
      dependencies = {"nvim-tree/nvim-web-devicons"}, -- use if you prefer nvim-web-devicons
      lazy = false,
    },
    {"nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      dependencies = {"nvim-telescope/telescope.nvim"},
    },
    {"nvim-telescope/telescope.nvim",
      config = function()
        local keymap = vim.keymap.set
        local telescope = require 'telescope'
        local builtin = require'telescope.builtin'
        local actions = require 'telescope.actions'
        local finders = require 'telescope.finders'
        local pickers = require("telescope.pickers")
        local previewers = require("telescope.previewers")
        local sorters = require("telescope.sorters")
        local conf = require('telescope.config').values

        telescope.setup {
          file_ignore_patterns = { "sorbet" },
          extensions = {
            fzf = {},
            directory = {},
          },
          defaults = {
            mappings = {
              i = {
                -- ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                ["<C-q>"] = actions.send_to_loclist + actions.open_loclist,
                ["<M-q>"] = actions.send_selected_to_loclist + actions.open_loclist,
              },
              n = {
                ["<C-q>"] = actions.send_to_loclist + actions.open_loclist,
                ["<M-q>"] = actions.send_selected_to_loclist + actions.open_loclist,
                ["cd"] = function(prompt_bufnr)
                  local selection = require("telescope.actions.state").get_selected_entry()
                  local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                  actions.close(prompt_bufnr)
                  vim.cmd(string.format("silent lcd %s", dir))
                end,
              },
            },
          },
          pickers = {
            buffers = {
              mappings = {
                i = {
                  ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
                },
              },
            },
          },
        }

        telescope.load_extension("directory")
        telescope.load_extension("fzf")
        telescope.load_extension("githubcoauthors")
        telescope.load_extension('gh')


        local function visit_yaml_node(node, name, yaml_path, result, file_path, bufnr)
            local key = ''
            if node:type() == "block_mapping_pair" then
                local field_key = node:field("key")[1]
                key = vim.treesitter.query.get_node_text(field_key, bufnr)
            end

            if key ~= nil and string.len(key) > 0 then
                table.insert(yaml_path, key)
                local line, col = node:start()
                table.insert(result, {
                    lnum = line + 1,
                    col = col + 1,
                    bufnr = bufnr,
                    filename = file_path,
                    text = table.concat(yaml_path, '.'),
                })
            end

            for node, name in node:iter_children() do
                visit_yaml_node(node, name, yaml_path, result, file_path, bufnr)
            end

            if key ~= nil and string.len(key) > 0 then
                table.remove(yaml_path, table.maxn(yaml_path))
            end
        end

        local function gen_from_yaml_nodes(opts)
            local displayer = entry_display.create {
                separator = " │ ",
                items = {
                    { width = 5 },
                    { remaining = true },
                },
            }

            local make_display = function(entry)
                return displayer {
                    { entry.lnum, "TelescopeResultsSpecialComment" },
                    { entry.text, function() return {} end },
                }
            end

            return function(entry)
                return make_entry.set_default_entry_mt({
                    ordinal = entry.text,
                    display = make_display,
                    filename = entry.filename,
                    lnum = entry.lnum,
                    text = entry.text,
                    col = entry.col,
                }, opts)
            end
        end

        local yaml_symbols = function(opts)
            local yaml_path = {}
            local result = {}
            local bufnr = vim.api.nvim_get_current_buf()
            local ft = vim.api.nvim_buf_get_option(bufnr, "ft")
            local tree = vim.treesitter.get_parser(bufnr, ft):parse()[1]
            local file_path = vim.api.nvim_buf_get_name(bufnr)
            local root = tree:root()
            for node, name in root:iter_children() do
                visit_yaml_node(node, name, yaml_path, result, file_path, bufnr)
            end

          -- return result
          pickers.new(opts, {
              prompt_title = "YAML symbols",
              finder = finders.new_table {
                  results = result,
                  entry_maker = opts.entry_maker or gen_from_yaml_nodes(opts),
              },
              sorter = conf.generic_sorter(opts),
              previewer = conf.grep_previewer(opts),
          })
          :find()
        end

        local dotfiles = function(opts)
          pickers.new(opts, {
            results_title = "Dotfiles",
            finder = finders.new_oneshot_job({"git", "--git-dir=$HOME/.dotfiles/", "--work-tree=$HOME", "ls-files"}),
            sorter = conf.generic_sorter(opts),
            -- previewer = conf.grep_previewer(opts),
          })
          :find()
        end

        keymap("n", "<localleader>ff", builtin.find_files)
        keymap("n", "<localleader>fb", builtin.buffers)
        keymap("n", "<localleader>fg", builtin.live_grep)
        keymap("n", "<localleader>fh", builtin.help_tags)
        keymap("n", "<localleader>fq", builtin.quickfix)
        keymap("n", "<localleader>fy", yaml_symbols)
        keymap("n", "<localleader>f.", dotfiles)
        keymap({"n", "v"}, "<localleader>w", builtin.grep_string)
        keymap("n", "<localleader>fa", telescope.extensions.githubcoauthors.coauthors)
        keymap("n", "<localleader>fd", telescope.extensions.directory.live_grep)
        keymap("n", "<localleader>fw", function()
          builtin.find_files {
            prompt_title = "Search ZK",
            shorten_path = false,
            cwd = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Zettle",
          }
        end)
      end,
    },
    {"fbuchlak/telescope-directory.nvim",
      dependencies = {"nvim-telescope/telescope.nvim"},
    },

    {"arthurxavierx/vim-caser"},
    {"easymotion/vim-easymotion",
      config = function()
        local keymap = vim.keymap.set
        keymap("n", "<localleader>m", "<Plug>(easymotion-prefix)")
      end,
    },
    {"junegunn/vim-easy-align"},
    {"machakann/vim-sandwich"},
    {"tpope/vim-eunuch"}, -- handle missing files and unix-y stuff
    {"wellle/targets.vim"}, -- expand the target objects
    {"junegunn/vim-peekaboo"}, -- Peekaboo extends " and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers.
    {"kopischke/vim-fetch"}, -- be able to open from stack traces (to line and column)
    {"tpope/vim-ragtag"}, -- handle html tags
    {"tpope/vim-repeat"}, -- repeat actions
    {"tpope/vim-speeddating"}, -- work with dates
    {"tpope/vim-unimpaired"}, -- bindings to toggle common settings

    {"hrsh7th/nvim-cmp",
      dependencies = {"neovim/nvim-lspconfig"},
    },
    {"hrsh7th/cmp-nvim-lsp"},
    {"hrsh7th/cmp-buffer"},
    {"hrsh7th/cmp-path"},
    {"hrsh7th/cmp-cmdline"},
    {"hrsh7th/cmp-vsnip"},
    {"hrsh7th/vim-vsnip"},
    {"petertriho/cmp-git",
      dependencies = {"nvim-lua/plenary.nvim"},
    },

    {"tpope/vim-projectionist"}, -- create and rename files by convention
    {"tpope/vim-rails"}, -- projectionist settings for rails

    -- git/gist/github
    {"pwntester/octo.nvim",
      dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "nvim-tree/nvim-web-devicons"},
    },
    {"lewis6991/gitsigns.nvim"}, -- Git integration for buffers (signs, status, etc)
    {"mattn/gist-vim",
      dependencies = {"mattn/webapi-vim"},
    },
    {"rhysd/git-messenger.vim", 
      lazy = true,
    }, -- display git commit info under cursor
    {"tpope/vim-fugitive"}, -- Git stuff
    {"tpope/vim-git"}, -- git file syntax
    {"tpope/vim-rhubarb"}, -- GitHub stuff
    {"cwebster2/github-coauthors.nvim",
      dependencies = {"nvim-telescope/telescope.nvim"},
    },

    { "nvim-telescope/telescope-github.nvim",
      dependencies = {"nvim-telescope/telescope.nvim"},
    },

    -- LSP
    {"neovim/nvim-lspconfig"},
    {"mattn/efm-langserver"},

    {"nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
    },
    {"nvim-treesitter/nvim-treesitter-textobjects",
      dependencies = "nvim-treesitter/nvim-treesitter",
    },
    {"nvim-treesitter/nvim-treesitter-context",
      dependencies = "nvim-treesitter/nvim-treesitter",
    },

    {"stevearc/aerial.nvim",
      config = function() require("aerial").setup() end,
    },

    -- Prose
    {"vimwiki/vimwiki",
      init = function()
        local keymap = vim.keymap.set
        keymap("n", "#-", "<Plug>VimwikiRemoveHeaderLevel", {noremap = true, silent = true})

        vim.g.vimwiki_key_mappings = {
          all_maps = 1,
          global = 1,
          headers = 1,
          text_objs = 1,
          table_format = 1,
          table_mappings = 1,
          lists = 1,
          links = 0,
          html = 1,
          mouse = 0
        }
        vim.g.vimwiki_global_ext = 0
        vim.g.vimwiki_list = {
          {
            path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Zettle/Oilcan",
            syntax = "markdown",
            ext = ".md",
            diary_rel_path = "Log/"
          },
          {
            path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Zettle",
            syntax = "markdown",
            ext = ".md",
            diary_rel_path = "Journal/"
          }
        }
      end,
      config = function()
        local keymap = vim.keymap.set
        keymap("n", "#-", "<Plug>VimwikiRemoveHeaderLevel", {noremap = true, silent = true})

        vim.api.nvim_set_var('vimwiki_key_mappings', {
          all_maps = 1,
          global = 1,
          headers = 1,
          text_objs = 1,
          table_format = 1,
          table_mappings = 1,
          lists = 1,
          links = 0,
          html = 1,
          mouse = 0
        })
        vim.api.nvim_set_var('vimwiki_global_ext', 0)
        vim.api.nvim_set_var('vimwiki_list', {
          {
            path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Zettle/Oilcan",
            syntax = "markdown",
            ext = ".md",
            diary_rel_path = "Log/"
          },
          {
            path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Zettle",
            syntax = "markdown",
            ext = ".md",
            diary_rel_path = "Journal/"
          }
        })
      end,
    },

    -- {"github/copilot.vim"},

    -- hm
    -- {
    --   "olimorris/codecompanion.nvim",
    --   dependencies = {
    --     "nvim-lua/plenary.nvim",
    --     "nvim-treesitter/nvim-treesitter",
    --   },
    --   -- config = true,
    --   opts = {
    --     adapters = {
    --       ollama = function()
    --         return require("codecompanion.adapters").extend("ollama", {
    --           schema = {
    --             model = {
    --               -- default = "mistral-small:24b",
    --               default = "deepseek-r1:latest",
    --             },
    --           },
    --         })
    --       end,
    --     },
    --     strategies = {
    --       chat = { adapter = "ollama" },
    --       inline = { adapter = "ollama" },
    --       agent = { adapter = "ollama" },
    --     },
    --   },
    -- },
    {"zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require('copilot').setup({
          -- panel = {
          --   enabled = true,
          --   auto_refresh = false,
          --   keymap = {
          --     jump_prev = "[[",
          --     jump_next = "]]",
          --     accept = "<CR>",
          --     refresh = "gr",
          --     open = "<M-CR>"
          --   },
          --   layout = {
          --     position = "bottom", -- | top | left | right | horizontal | vertical
          --     ratio = 0.4
          --   },
          -- },
          -- suggestion = {
          --   enabled = true,
          --   auto_trigger = false,
          --   hide_during_completion = true,
          --   debounce = 75,
          --   keymap = {
          --     accept = "<M-l>",
          --     accept_word = false,
          --     accept_line = false,
          --     next = "<M-]>",
          --     prev = "<M-[>",
          --     dismiss = "<C-]>",
          --   },
          -- },
          -- filetypes = {
          --   yaml = false,
          --   markdown = false,
          --   help = false,
          --   gitcommit = false,
          --   gitrebase = false,
          --   hgcommit = false,
          --   svn = false,
          --   cvs = false,
          --   ["."] = false,
          -- },
          -- logger = {
          --   file = vim.fn.stdpath("log") .. "/copilot-lua.log",
          --   file_log_level = vim.log.levels.OFF,
          --   print_log_level = vim.log.levels.WARN,
          --   trace_lsp = "off", -- "off" | "messages" | "verbose"
          --   trace_lsp_progress = false,
          --   log_lsp_messages = false,
          -- },
          -- copilot_node_command = 'node', -- Node.js version must be > 18.x
          -- workspace_folders = {},
          -- copilot_model = "",  -- Current LSP default is gpt-35-turbo, supports gpt-4o-copilot
          -- root_dir = function()
          --   return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
          -- end,
          -- should_attach = nil, -- type is fun(bufnr: integer, bufname: string): boolean
          -- server_opts_overrides = {},
        })
      end,
    },
    {"yetone/avante.nvim",
      event = "VeryLazy",
      version = false, -- Never set this value to "*"! Never!
      opts = {
        -- add any opts here
        -- for example
        provider = "copilot",
        -- openai = {
        --   endpoint = "https://api.openai.com/v1",
        --   model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        --   timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        --   temperature = 0,
        --   max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        --   --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
        -- },
      },
      -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
      build = "make",
      -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        "ibhagwan/fzf-lua", -- for file_selector provider fzf
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
          -- support for image pasting
          "HakonHarnes/img-clip.nvim",
          event = "VeryLazy",
          opts = {
            -- recommended settings
            default = {
              embed_image_as_base64 = false,
              prompt_for_file_name = false,
              drag_and_drop = {
                insert_mode = true,
              },
              -- required for Windows users
              use_absolute_path = true,
            },
          },
        },
        {
          -- Make sure to set this up properly if you have lazy=true
          'MeanderingProgrammer/render-markdown.nvim',
          opts = {
            file_types = { "markdown", "Avante" },
          },
          ft = { "markdown", "Avante" },
        },
      },
    },
  },
  checker = { enabled = true },
})

vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")
vim.go.clipboard = "unnamed"

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Tab Completion
vim.o.wildmode = "list:longest,full"
vim.opt.wildignore = "*.swp,*.o,*.so,*.exe,*.dll"

-- Tab settings
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.wo.foldenable = false

-- Hud
vim.o.termguicolors = true
-- vim.o.ruler = true
vim.o.showmode = false
vim.o.number = false
vim.o.wrap = false
vim.o.fillchars = "vert:│"
vim.o.textwidth = 120
vim.o.hidden = true
vim.o.listchars = "tab:»·,trail:·"
vim.o.list = true
vim.o.scrolloff = 3

vim.api.nvim_create_augroup("EnterLeave", {
  clear = true
})
vim.api.nvim_create_autocmd({"VimEnter", "WinEnter"}, {
  pattern = {"*"},
  group = "EnterLeave",
  callback = function(ev)
    vim.o.number = true
  end,
})
vim.api.nvim_create_autocmd({"WinLeave"}, {
  pattern = {"*"},
  group = "EnterLeave",
  callback = function(ev)
    vim.o.number = false
  end,
})

-- Window settings
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.showmode = false

-- Neovim specific settings
vim.o.inccommand = "split"

local keymap = vim.keymap.set

-- General keymaps
keymap("n", "<tab>", "%")
keymap("n", "<leader>ts", "<cmd>.! date -R<cr>")
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
keymap("n", "[t", ":tabprevious<cr>")
keymap("n", "]t", ":tabnext<cr>")
keymap("n", "g.", 'i<cr><ESC>:.-1read !date -Iseconds<CR>I<BS><ESC>j0i<BS><ESC>l')
keymap("i", "<c-s>", '<cr><ESC>:.-1read !date -Iseconds<CR>I<BS><ESC>j0i<BS><ESC>l')

-- THEME
require('nightfox').setup({
  options = {
    transparent = true,
  }
})
vim.cmd('colorscheme carbonfox')
if os.getenv("termTheme") == "light" then
  vim.o.background = "light"
end

-- LUALINE
local navic = require("nvim-navic")
local colors = {
  red = '#ca1243',
  grey = '#a0a1a7',
  black = '#0d1117',
  white = '#f3f3f3',
  light_green = '#83a598',
  orange = '#fe8019',
  green = '#8ec07c',
}

local theme = {
  normal = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.white },
    z = { fg = colors.white, bg = colors.black },
  },
  insert = { a = { fg = colors.black, bg = colors.light_green } },
  visual = { a = { fg = colors.black, bg = colors.orange } },
  replace = { a = { fg = colors.black, bg = colors.green } },
}

local empty = require('lualine.component'):extend()
function empty:draw(default_highlight)
  self.status = ''
  self.applied_separator = ''
  self:apply_highlights(default_highlight)
  self:apply_section_separators()
  return self.status
end

-- Put proper separators and gaps between components in sections
local function process_sections(sections)
  for name, section in pairs(sections) do
    local left = name:sub(9, 10) < 'x'
    for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
      table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.white } })
    end
    for id, comp in ipairs(section) do
      if type(comp) ~= 'table' then
        comp = { comp }
        section[id] = comp
      end
      comp.separator = left and { right = '' } or { left = '' }
    end
  end
  return sections
end

local function search_result()
  if vim.v.hlsearch == 0 then
    return ''
  end
  local last_search = vim.fn.getreg('/')
  if not last_search or last_search == '' then
    return ''
  end
  local searchcount = vim.fn.searchcount { maxcount = 9999 }
  return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
end

local function modified()
  if vim.bo.modified then
    return '+'
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
    return '-'
  end
  return ''
end

require('lualine').setup {
  options = {
    theme = 'auto', -- theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = process_sections {
    lualine_a = {},
    lualine_b = {
      { 'filename', file_status = false, path = 1 },
      'branch',
      'diff',
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'error' },
        diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
      },
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'warn' },
        diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
      },
      { modified, color = { bg = colors.red } },
      {
        '%w',
        cond = function()
          return vim.wo.previewwindow
        end,
      },
      {
        '%r',
        cond = function()
          return vim.bo.readonly
        end,
      },
      {
        '%q',
        cond = function()
          return vim.bo.buftype == 'quickfix'
        end,
      },
    },
    lualine_c = {
      {"navic"}
    },
    lualine_x = {
      { 'mode', fmt = function(str) return str:sub(1,1) end },
    },
    lualine_y = { search_result, 'filetype' },
    lualine_z = { '%l:%c', '%p%%/%L' },
  },
  inactive_sections = {
    lualine_c = { '%f %y %m' },
    lualine_x = {},
  },
}


-- UI
gitsigns = require("gitsigns")
gitsigns.setup()

-- terminal
keymap("t", "<esc>", "<C-\\><C-n>")
keymap("t", "<c-h>", "<C-\\><C-n><c-w>h")
keymap("t", "<c-j>", "<C-\\><C-n><c-w>j")
keymap("t", "<c-k>", "<C-\\><C-n><c-w>k")
keymap("t", "<c-l>", "<C-\\><C-n><c-w>l")

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- cmp
local cmp = require "cmp"
require("cmp_git").setup()
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end
  },
  mapping = {
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
      ["<CR>"] = cmp.mapping.confirm({select = false}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = cmp.mapping(
          function(fallback)
              if cmp.visible() then
                  cmp.select_next_item()
              elseif has_words_before() then
                  cmp.complete()
              else
                  fallback()
              end
          end,
          {"i", "s"}
      ),
      ["<S-Tab>"] = cmp.mapping(
          function(fallback)
              if cmp.visible() then
                  cmp.select_prev_item()
              else
                  fallback()
              end
          end,
          {"i", "s"}
      )
  },
  sources = cmp.config.sources(
      {
          {name = "nvim_lsp"},
          {name = "vsnip"}
      },
      {
          {name = "buffer"}
      }
  )
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


-- easyalign
keymap("v", "ga", "<Plug>(EasyAlign)")
keymap("n", "ga", "<Plug>(EasyAlign)")
keymap("n", "gA", ":ascii<cr>")

-- vim-sandwich
function _G.structInput()
    local structName = vim.fn.input("Struct: ")
    local startBun = ""
    if (structName ~= "") then
        startBun = "%" .. structName .. "{"
    else
        error("OperatorSandwichCancel")
    end
    return {startBun, "}"}
end
local sandwich_recipes = vim.api.nvim_eval("sandwich#default_recipes")
local custom_recipes = {
    {
        buns = {"${", "}"},
        filetype = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
        input = {"$"},
        nesting = 1
    },
    {
        buns = {"%{", "}"},
        filetype = {"elixir"},
        input = {"m"},
        nesting = 1
    },
    {
        buns = "v:lua.structInput()",
        filetype = {"elixir"},
        kind = {"add", "replace"},
        action = {"add"},
        input = {"M"},
        listexpr = 1,
        nesting = 1
    },
    {
        buns = {[[%\w\+{]], "}"},
        filetype = {"elixir"},
        input = {"M"},
        nesting = 1,
        regex = 1
    },
    {
        buns = {"<%= ", " %>"},
        filetype = {"eruby", "eelixir"},
        input = {"="},
        nesting = 1
    },
    {
        buns = {"<% ", " %>"},
        filetype = {"eruby", "eelixir"},
        input = {"-"},
        nesting = 1
    },
    {
        buns = {"<%# ", " %>"},
        filetype = {"eruby", "eelixir"},
        input = {"#"},
        nesting = 1
    },
    {
        buns = {"#{", "}"},
        filetype = {"ruby"},
        input = {"s"},
        nesting = 1
    },
    {
        buns = {"[", "]()"},
        filetype = {"markdown"},
        input = {"l"},
        nesting = 1,
        cursor = "tail"
    },
    {
        buns = {"<mark>", "</mark>"},
        filetype = {"markdown"},
        input = {"m"},
        nesting = 1
    }
}
vim.list_extend(sandwich_recipes, custom_recipes)
vim.g["sandwich#recipes"] = sandwich_recipes

-- LSP
local lspconfig = require("lspconfig")

vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})
keymap('n', '<leader>e', vim.diagnostic.open_float)
keymap('n', '[d', vim.diagnostic.goto_prev)
keymap('n', ']d', vim.diagnostic.goto_next)
keymap('n', '<leader>q', vim.diagnostic.setloclist)
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    keymap('n', 'gD', vim.lsp.buf.declaration, opts)
    keymap('n', 'gd', vim.lsp.buf.definition, opts)
    keymap('n', 'gt', vim.lsp.buf.type_definition, opts)
    keymap('n', 'gi', vim.lsp.buf.implementation, opts)
    keymap('n', 'gr', vim.lsp.buf.references, opts)
    keymap('n', 'K', vim.lsp.buf.hover, opts)
    keymap('n', 'gk', vim.lsp.buf.signature_help, opts)
    -- keymap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- keymap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- keymap('n', '<space>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
    keymap({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    keymap('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.pylsp.setup { capabilities = capabilities }
lspconfig.ts_ls.setup { capabilities = capabilities }
lspconfig.solargraph.setup { capabilities = capabilities }
lspconfig.sorbet.setup { capabilities = capabilities }
lspconfig.tailwindcss.setup{ capabilities = capabilities }
lspconfig.rubocop.setup {
  capabilities = capabilities,
  filetypes = { "ruby" },
}

local eslint = {
  lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename=${INPUT}",
  lintStdin = true,
  lintFormats = {
    "%f(%l,%c): %trror %m",
    "%f(%l,%c): %tarning %m"
  },
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}
local yamllint = {
  lintCommand = "yamllint -f parsable - ",
  lintStdin = true,
  lintFormats = {
    "%f:%l:%c: [%trror] %m",
    "%f:%l:%c: [%tarning] %m",
  },
}
local erb_lint = {
  -- lintCommand = "erb_lint --config ./.erb_lint.yml --format compact --stdin ${INPUT}",
  lintCommand = "erb_lint --format compact --stdin ${INPUT}",
  lintStdin = true,
  lintFormats = {
    "%f:%l:%c: %m",
  },
  lintSource = "erb_lint",
  formatCommand = "erb_lint --autocorrect --stdin ${INPUT} | tail -n +5",
  formatStdin = true,
}
-- local eruby = {
--   lintDebounce = 2,
--   lintCommand = "erb -x -T - | ruby -c",
--   lintStdin = true,
--   lintOffset = 1,
--   formatCommand = htmlbeautifier,
--   formatStdin = true,
-- }

lspconfig.efm.setup {
  -- cmd = {"efm-langserver", "-logfile", "/tmp/efm.log", "-loglevel", "1" },
  capabilities = capabilities,
  init_options = { documentFormatting = true },
  settings = {
    rootMarkers = {".git/"},
    languages = {
      javascript = {eslint},
      javascriptreact = {eslint},
      ["javascript.jsx"] = {eslint},
      typescript = {eslint},
      ["typescript.tsx"] = {eslint},
      typescriptreact = {eslint},
      eruby = {erb_lint},
      ["eruby.yaml"] = {yamllint},
      yaml = {yamllint},
      yml = {yamllint},
    }
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "eruby",
    "eruby.yaml",
    "yaml",
    "yml",
  }
}


require "nvim-treesitter.configs".setup {
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner"
      }
    }
  }
}
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.markdown.filetype_to_parsername = "octo"
require "octo".setup(
  {
    default_to_projects_v2 = true,
    default_merge_method = "squash",
    mappings = {
      submit_win = {
        approve_review = { lhs = "<C-p>", desc = "approve review" },
        comment_review = { lhs = "<C-m>", desc = "comment review" },
        request_changes = { lhs = "<C-r>", desc = "request changes review" },
        close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
      },
    }
  }
)


-- git
keymap("n", "]g", "<cmd>Gitsigns next_hunk<CR>", { silent = true })
keymap("n", "[g", "<cmd>Gitsigns prev_hunk<CR>", { silent = true })
keymap("n", "<leader>g", ":Git<cr>", { silent = true })

-- -- vimwiki

-- Highlight when yanking (copying) text
-- Try it with 'yap' in normal mode
-- See ':help vim.highlight.on_yank()'
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function ()
    vim.highlight.on_yank ()
  end,
})
