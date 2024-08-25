-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")
vim.g.mapleader = ","
vim.g.maplocalleader = ","
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

-- TSInstall bash comment css dockerfile go graphql html javascript jsdoc json lua make markdown prisma php python ruby rust scss svelte toml tsx typescript vim vue yaml
-- PLUGINS
vim.cmd [[packadd packer.nvim]]
require("packer").startup(
  function()
    use {"wbthomason/packer.nvim"}

    use {"editorconfig/editorconfig-vim"} -- editorconfig for being polite
    use {"EdenEast/nightfox.nvim"}

    use {"christoomey/vim-tmux-navigator"} -- navigate across tmux splits
    use {"nvim-lua/popup.nvim"}
    use {"norcalli/nvim-colorizer.lua"} -- color hex/rgb strings
    -- use "junegunn/fzf"
    -- use "junegunn/fzf.vim"
    use {"nvim-lualine/lualine.nvim",
      requires = {"nvim-tree/nvim-web-devicons"},
    }
    use {"tpope/vim-vinegar"} -- use netrw with style
    use {"SmiteshP/nvim-navic",
      requires = {"neovim/nvim-lspconfig"},
    }
    use {"nvim-telescope/telescope.nvim"}
    use {"fbuchlak/telescope-directory.nvim",
      requires = {"nvim-telescope/telescope.nvim"}
    }

    use {"arthurxavierx/vim-caser"}
    use {"easymotion/vim-easymotion"}
    use {"junegunn/vim-easy-align"}
    use {"machakann/vim-sandwich"}
    -- This may not be needed after nvim 0.10:
    -- use "tpope/vim-commentary" -- easy comments
    use {"tpope/vim-eunuch"} -- handle missing files and unix-y stuff
    use {"wellle/targets.vim"} -- expand the target objects
    use {"junegunn/vim-peekaboo"} -- Peekaboo extends " and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers.
    use {"kopischke/vim-fetch"} -- be able to open from stack traces (to line and column)
    use {"tpope/vim-ragtag"} -- handle html tags
    use {"tpope/vim-repeat"} -- repeat actions
    use {"tpope/vim-speeddating"} -- work with dates
    use {"tpope/vim-unimpaired"} -- bindings to toggle common settings

    use {"hrsh7th/nvim-cmp",
      requires = {"neovim/nvim-lspconfig"},
    }
    use {"hrsh7th/cmp-nvim-lsp"}
    use {"hrsh7th/cmp-buffer"}
    use {"hrsh7th/cmp-path"}
    use {"hrsh7th/cmp-cmdline"}
    use {"hrsh7th/cmp-vsnip"}
    use {"hrsh7th/vim-vsnip"}
    use {"petertriho/cmp-git",
      requires = {"nvim-lua/plenary.nvim"},
    }

    use {"tpope/vim-projectionist"} -- create and rename files by convention
    use {"tpope/vim-rails"} -- projectionist settings for rails

    -- git/gist/github
    use {"pwntester/octo.nvim",
      requires = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "nvim-tree/nvim-web-devicons"},
    }
    use {"lewis6991/gitsigns.nvim"} -- Git integration for buffers (signs, status, etc)
    use {"mattn/gist-vim",
      requires = {"mattn/webapi-vim"},
    }
    use {"rhysd/git-messenger.vim", opt = true} -- display git commit info under cursor
    use {"tpope/vim-fugitive"} -- Git stuff
    use {"tpope/vim-git"} -- git file syntax
    use {"tpope/vim-rhubarb"} -- GitHub stuff
    use {"cwebster2/github-coauthors.nvim"}

    -- LSP
    use {"neovim/nvim-lspconfig"}
    use {"mattn/efm-langserver"}

    use {"nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    };
    use {"nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
      requires = "nvim-treesitter/nvim-treesitter",
    }

    -- Prose
    use {"iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
    }
    use {"vimwiki/vimwiki",
      branch = "dev"
    }

    -- osc52 clipboard
    -- use {
    --   "ojroques/nvim-osc52",
    --   config = function()
    --     require"osc52".setup {
    --       silent = true,
    --       tmux_passthrough = true,
    --     }
    --   end
    -- }
  end
)

-- clipboard
-- local function copy(lines, _)
--   require('osc52').copy(table.concat(lines, '\n'))
-- end

-- local function paste()
--   return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
-- end

-- vim.g.clipboard = {
--   name = 'osc52',
--   copy = {['+'] = copy, ['*'] = copy},
--   paste = {['+'] = paste, ['*'] = paste},
-- }

-- -- -- Now the '+' register will copy to system clipboard using OSC52
-- -- keymap('n', '<leader>c', '"+y')
-- -- keymap('n', '<leader>cc', '"+yy')

-- keymap('n', '<leader>c', require('osc52').copy_operator, {expr = true})
-- keymap('n', '<leader>cc', '<leader>c_', {remap = true})
-- keymap('v', '<leader>c', require('osc52').copy_visual)

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

-- telescope for finding stuff
local telescope = require 'telescope'
local builtin = require'telescope.builtin'
local actions = require 'telescope.actions'
keymap('n', '<leader>w', '<cmd>lua require(\'telescope.builtin\').grep_string({search = vim.fn.expand("<cword>")})<cr>', {})

telescope.setup{
  file_ignore_patterns = { "sorbet" },
  extensions = {
    directory = {},
  },
  defaults = {
    mappings = {
      i = {
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    }
  },
}
telescope.load_extension("directory")
telescope.load_extension("githubcoauthors")
function _G.searchWiki()
  builtin.find_files {
    prompt_title = "Search ZK",
    shorten_path = false,
    cwd = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Zettle"
  }
end

keymap("n", "<localleader>ff", builtin.find_files)
keymap("n", "<localleader>fb", builtin.buffers)
keymap("n", "<localleader>fg", builtin.live_grep)
keymap("n", "<localleader>fq", builtin.quickfix)
keymap("n", "<localleader>fa", telescope.extensions.githubcoauthors.coauthors)
keymap("n", "<localleader>fd", "<cmd>Telescope directory live_grep<cr>")
keymap("n", "<localleader>fw", _G.searchWiki)

-- terminal
keymap("t", "<esc>", "<C-\\><C-n>")
keymap("t", "<c-h>", "<C-\\><C-n><c-w>h")
keymap("t", "<c-j>", "<C-\\><C-n><c-w>j")
keymap("t", "<c-k>", "<C-\\><C-n><c-w>k")
keymap("t", "<c-l>", "<C-\\><C-n><c-w>l")

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

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

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

lspconfig.pylsp.setup { capabilities = capabilities }
lspconfig.tsserver.setup { capabilities = capabilities }
lspconfig.solargraph.setup { capabilities = capabilities }
lspconfig.sorbet.setup { capabilities = capabilities }
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
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}
-- local eruby = {
--   lintDebounce = 2,
--   lintCommand = "erb -x -T - | ruby -c",
--   lintStdin = true,
--   lintOffset = 1,
--   formatCommand = htmlbeautifier,
--   formatStdin = true,
-- }
local erblint = {
  lintCommand = "erblint --config ./.erb-lint.yml --format compact --stdin ${FILENAME}",
  lintStdin = true,
  lintFormats = {
    "%f:%l:%c: %m",
  },
  lintIgnoreExitCode = true,
  lintSource = "erblint",
  formatCommand = "erblint --autocorrect --stdin ${FILENAME} | tail -n +5",
  formatStdin = true,
}
local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end
lspconfig.efm.setup {
  capabilities = capabilities,
  init_options = { documentFormatting = true },
  -- on_attach = function(client, bufnr)
  --   client.server_capabilities.document_formatting = true
  --   client.server_capabilities.goto_definition = false
  --   on_attach(client, bufnr)
  -- end,
  -- root_dir = function()
  --   if not eslint_config_exists() then
  --       return nil
  --   end
  --   return vim.fn.getcwd()
  -- end,
  settings = {
    rootMarkers = {".git/"},
    languages = {
      javascript = {eslint},
      javascriptreact = {eslint},
      ["javascript.jsx"] = {eslint},
      typescript = {eslint},
      ["typescript.tsx"] = {eslint},
      typescriptreact = {eslint},
      eruby = {erblint},
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

-- vimwiki
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
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Zettle/Jeli",
        syntax = "markdown",
        ext = ".md",
        diary_rel_path = "Log Book/"
    },
    {
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Zettle",
        syntax = "markdown",
        ext = ".md",
        diary_rel_path = "Journal/"
    }
}
keymap("n", "#-", "<Plug>VimwikiRemoveHeaderLevel", {noremap = true, silent = true})
