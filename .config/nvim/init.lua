-- Load .vimrc
vim.cmd([[runtime .vimrc]])

-- Neovim specific settings
vim.o.inccommand = "split"

vim.o.splitbelow = true
vim.o.splitright = true
vim.o.completeopt = "menu,menuone,noselect"

-- TSInstall bash comment css dockerfile go graphql html javascript jsdoc json lua make markdown prisma php python ruby rust scss svelte toml tsx typescript vim vue yaml
-- PLUGINS
vim.cmd [[packadd packer.nvim]]
require("packer").startup(
    function()
        use "wbthomason/packer.nvim"
        -- UI
        use "arthurxavierx/vim-caser"
        use "chriskempson/base16-vim"
        use "christoomey/vim-tmux-navigator" -- navigate across tmux splits
        use "easymotion/vim-easymotion"
        use "editorconfig/editorconfig-vim" -- editorconfig for being polite
        -- 'hrsh7th/vim-vsnip'
        -- use 'itchyny/vim-cursorword'
        use "junegunn/fzf"
        use "junegunn/fzf.vim"
        use "junegunn/vim-easy-align"
        use "junegunn/vim-peekaboo" -- Peekaboo extends " and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers.
        use "JoosepAlviste/nvim-ts-context-commentstring" -- more complex commentstring
        use "kopischke/vim-fetch" -- be able to open from stack traces
        use "machakann/vim-sandwich"
        -- use 'mattn/emmet-vim'
        use "norcalli/nvim-colorizer.lua" -- color hex/rgb strings
        use "nvim-lualine/lualine.nvim"
        use {
            "SmiteshP/nvim-gps", -- nvim-gps is a simple status line component that shows context of the current cursor position in file
            requires = "nvim-treesitter/nvim-treesitter"
        }
        use "tpope/vim-abolish" -- rename... could be LSP'd away someday
        use "tpope/vim-commentary" -- easy comments
        use "tpope/vim-eunuch" -- handle missing files and unix-y stuff
        use "tpope/vim-projectionist" -- create and rename files by convention
        use "tpope/vim-ragtag" -- handle html tags
        use "tpope/vim-repeat" -- repeat actions
        use "tpope/vim-speeddating" -- work with dates
        use "tpope/vim-unimpaired" -- bindings to toggle common settings
        use "tpope/vim-vinegar" -- use netrw with style
        use "wellle/targets.vim" -- expand the target objects
        -- Syntax
        -- git/gist/github
        use "lewis6991/gitsigns.nvim" -- gitsigns
        use "mattn/gist-vim"
        use "mattn/webapi-vim"
        use "rhysd/git-messenger.vim"
        use "sbdchd/neoformat"
        use "tpope/vim-fugitive"
        use "tpope/vim-git"
        use "tpope/vim-rhubarb"
        -- LSP
        use "neovim/nvim-lspconfig"
        use "mattn/efm-langserver"
        use "tami5/lspsaga.nvim"

        use "hrsh7th/cmp-nvim-lsp"
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-path"
        use "hrsh7th/cmp-cmdline"
        use "hrsh7th/nvim-cmp"

        use "nvim-lua/lsp_extensions.nvim"
        use "nvim-lua/plenary.nvim"
        use "nvim-lua/popup.nvim"
        use "nvim-telescope/telescope.nvim"
        use "cwebster2/github-coauthors.nvim"
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate"
        }
        use "nvim-treesitter/nvim-treesitter-textobjects"
        -- Prose
        use {
            "vimwiki/vimwiki",
            branch = "dev"
        }
    end
)

-- THEME
vim.cmd [[colorscheme base16-default-dark]]
if vim.fn.filereadable(vim.fn.expand("~/.vimrc_background")) then
    vim.api.nvim_exec("source ~/.vimrc_background", false)
end

-- statusline
-- local function treesitterStatus()
--   return [[nvim_treesitter#statusline(90)]]
-- end
local gps = require("nvim-gps")
gps.setup()

require("lualine").setup {
    options = {
        theme = "auto"
    },
    sections = {
        lualine_a = {"mode"},
        -- lualine_b = {'branch', 'diff', {'diagnostics', sources={'nvim_lsp', 'coc'}}},
        -- lualine_a = {"require'nvim-treesitter'#statusline(90)"},
        lualine_b = {{gps.get_location, condition = gps.is_available}},
        lualine_c = {"branch", "diff", {"filename", file_status = true, path = 1}},
        -- lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_x = {{"diagnostics", sources = {"nvim_lsp"}}},
        lualine_y = {"progress"},
        lualine_z = {"location"}
    }
}

vim.o.showmode = false
if os.getenv("termTheme") == "light" then
    vim.o.background = "light"
end

vim.api.nvim_set_keymap("n", "<tab>", "%", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>ts", "<cmd>.! date -R<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<", "<gv", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", ">", ">gv", {noremap = true, silent = true})

-- UI
gitsigns = require("gitsigns")
gitsigns.setup()

-- fzf
vim.api.nvim_set_keymap("n", "<localleader>fb", ":Buffers<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>ff", ":Files<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>fl", ":Lines<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>fg", ":Rg<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap(
    "n",
    "<localleader>fw",
    ":Files ~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Zettle<cr>",
    {noremap = true, silent = true}
)

-- telescope for finding stuff
require("telescope").load_extension("githubcoauthors")
function _G.searchWiki()
    require("telescope.builtin").find_files {
        prompt_title = "Search ZK",
        shorten_path = false,
        cwd = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Zettle"
    }
end

vim.api.nvim_set_keymap(
    "n",
    "<localleader>tf",
    ":lua require('telescope.builtin').find_files()<cr>",
    {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
    "n",
    "<localleader>tb",
    ":lua require('telescope.builtin').buffers()<cr>",
    {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
    "n",
    "<localleader>tg",
    ":lua require('telescope.builtin').live_grep()<cr>",
    {noremap = true, silent = true}
)
vim.api.nvim_set_keymap("n", "<localleader>tw", ":lua _G.searchWiki()<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap(
    "n",
    "<localleader>ta",
    ":lua require('telescope').extensions.githubcoauthors.coauthors()<cr>",
    {noremap = true, silent = true}
)

-- compe
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require "cmp"

cmp.setup(
    {
        mapping = {
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
            ["<CR>"] = cmp.mapping.confirm({select = true}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
        -- mapping = {
        --     ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
        --     ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
        --     ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
        --     ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        --     ["<C-e>"] = cmp.mapping(
        --         {
        --             i = cmp.mapping.abort(),
        --             c = cmp.mapping.close()
        --         }
        --     ),
        --     ["<CR>"] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        -- },
        sources = cmp.config.sources(
            {
                {name = "nvim_lsp"},
                {name = "vsnip"} -- For vsnip users.
            },
            {
                {name = "buffer"}
            }
        )
    }
)

-- Set configuration for specific filetype.
cmp.setup.filetype(
    "gitcommit",
    {
        sources = cmp.config.sources(
            {
                {name = "cmp_git"} -- You can specify the `cmp_git` source if you were installed it.
            },
            {
                {name = "buffer"}
            }
        )
    }
)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
    "/",
    {
        sources = {
            {name = "buffer"}
        }
    }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
    ":",
    {
        sources = cmp.config.sources(
            {
                {name = "path"}
            },
            {
                {name = "cmdline"}
            }
        )
    }
)

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require("lspconfig")["<YOUR_LSP_SERVER>"].setup {
--     capabilities = capabilities
-- }
-- require "compe".setup {
--     enabled = true,
--     autocomplete = true,
--     debug = false,
--     min_length = 1,
--     preselect = "enable",
--     throttle_time = 80,
--     source_timeout = 200,
--     incomplete_delay = 400,
--     max_abbr_width = 100,
--     max_kind_width = 100,
--     max_menu_width = 100,
--     documentation = true,
--     source = {
--         nvim_lsp = {menu = "[LSP]", priority = 10, sort = false},
--         -- vsnip = {menu = "[VS]", priority = 10},
--         nvim_lua = {menu = "[LUA]", priority = 9},
--         path = {menu = "[PATH]", priority = 9},
--         treesitter = {menu = "[TS]", priority = 9},
--         buffer = {menu = "[BUF]", priority = 8},
--         spell = {menu = "[SPL]"}
--     }
-- }

-- local t = function(str)
--     return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end

-- local check_back_space = function()
--     local col = vim.fn.col(".") - 1
--     if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
--         return true
--     else
--         return false
--     end
-- end

-- -- Use (s-)tab to:
-- --- move to prev/next item in completion menuone
-- --- jump to prev/next snippet's placeholder
-- _G.tab_complete = function()
--     if vim.fn.pumvisible() == 1 then
--         -- elseif vim.fn.call("vsnip#available", {1}) == 1 then
--         --   return t "<Plug>(vsnip-expand-or-jump)"
--         return t "<C-n>"
--     elseif check_back_space() then
--         return t "<Tab>"
--     else
--         return vim.fn["compe#complete"]()
--     end
-- end
-- _G.s_tab_complete = function()
--     if vim.fn.pumvisible() == 1 then
--         -- elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
--         --   return t "<Plug>(vsnip-jump-prev)"
--         return t "<C-p>"
--     else
--         return t "<S-Tab>"
--     end
-- end

-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- neoformat
vim.api.nvim_set_keymap("n", "<leader>F", ":Neoformat<cr>", {})

-- easyalign
vim.api.nvim_set_keymap("v", "ga", "<Plug>(EasyAlign)", {})
vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {})
vim.api.nvim_set_keymap("n", "gA", ":ascii", {})

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

-- LSP LANGUAGE SERVERS
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = {noremap = true, silent = true}
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", opts)
    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
    hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
    hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
    hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
    augroup lsp_document_highlight autocmd!
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
            false
        )
    end

    if client.config.flags then
        client.config.flags.allow_incremental_sync = true
    end
    client.resolved_capabilities.document_formatting = false
    -- require'completion'.on_attach()
end

local lspconfig = require("lspconfig")

local function root_pattern(...)
    local patterns = vim.tbl_flatten {...}

    return function(startpath)
        for _, pattern in ipairs(patterns) do
            return lspconfig.util.search_ancestors(
                startpath,
                function(path)
                    if lspconfig.util.path.exists(vim.fn.glob(lspconfig.util.path.join(path, pattern))) then
                        return path
                    end
                end
            )
        end
    end
end

lspconfig.tsserver.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

local eslint = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintIgnoreExitCode = true,
    formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
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
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = true
        client.resolved_capabilities.goto_definition = false
        on_attach(client, bufnr)
    end,
    root_dir = function()
        if not eslint_config_exists() then
            return nil
        end
        return vim.fn.getcwd()
    end,
    settings = {
        languages = {
            javascript = {eslint},
            javascriptreact = {eslint},
            ["javascript.jsx"] = {eslint},
            typescript = {eslint},
            ["typescript.tsx"] = {eslint},
            typescriptreact = {eslint}
        }
    },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescript.tsx",
        "typescriptreact"
    }
}

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldenable = false
require "nvim-treesitter.configs".setup {
    context_commentstring = {
        enable = true
    },
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

-- floating windows
local saga = require("lspsaga")
saga.init_lsp_saga()
-- code finder
vim.api.nvim_set_keymap(
    "n",
    "gh",
    "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>",
    {noremap = true, silent = true}
)
-- docs
vim.api.nvim_set_keymap(
    "n",
    "K",
    "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>",
    {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
    "n",
    "<C-f>",
    "<cmd>lua require('lspsaga.hover').smart_scroll_hover(1)<CR>",
    {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
    "n",
    "<C-b>",
    "<cmd>lua require('lspsaga.hover').smart_scroll_hover(-1)<CR>",
    {noremap = true, silent = true}
)
-- code actions
vim.api.nvim_set_keymap(
    "n",
    "<space>ca",
    "<cmd>lua require('lspsaga.codeaction').code_action()<CR>",
    {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
    "v",
    "<space>ca",
    "<cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>",
    {noremap = true, silent = true}
)
-- signature help
vim.api.nvim_set_keymap(
    "n",
    "<space>k",
    "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>",
    {noremap = true, silent = true}
)
-- rename
vim.api.nvim_set_keymap(
    "n",
    "<space>n",
    "<cmd>lua require('lspsaga.rename').rename()<CR>",
    {noremap = true, silent = true}
)
-- preview definition
vim.api.nvim_set_keymap(
    "n",
    "<space>gd",
    "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>",
    {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
    "n",
    "<space>gd",
    "<cmd>lua require'lspsaga.provider'.preview_declaration()<CR>",
    {noremap = true, silent = true}
)
-- diagnostics
vim.api.nvim_set_keymap(
    "n",
    "<space>d",
    "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>",
    {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
    "n",
    "[d",
    '<cmd>lua require\'lspsaga.diagnostic\'.navigate("prev")()<CR>',
    {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
    "n",
    "]d",
    '<cmd>lua require\'lspsaga.diagnostic\'.navigate("next")()<CR>',
    {noremap = true, silent = true}
)
-- git
vim.api.nvim_set_keymap("n", "]g", "<cmd>Gitsigns next_hunk<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "]g", "<cmd>Gitsigns prev_hunk<CR>", {noremap = true, silent = true})
-- EFM

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

vim.api.nvim_set_keymap("n", "#-", "<Plug>VimwikiRemoveHeaderLevel", {noremap = true, silent = true})
