-- @param filename string: filename in the root of the dir.
-- @return boolean: true if the file exists in the project root.
local function root_has_file(filename)
    local filepath = vim.fn.expand('%:p:h') .. '/' .. filename
    return vim.fn.filereadable(filepath) == 1
end

local lsp = require('lsp-zero')
local cmp = require('cmp')


-- lsp.setup_servers({"gopls", "lua_ls"})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)

-- lsp.omni

lsp.setup()

local su = cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    },
    mapping = {
        ['<C-y>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<Up>'] = cmp.mapping.select_prev_item(cmp_select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(cmp_select_opts),
        ['<C-p>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item(cmp_select_opts)
            else
                cmp.complete()
            end
        end),
        ['<C-n>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item(cmp_select_opts)
            else
                cmp.complete()
            end
        end),
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        documentation = {
            max_height = 15,
            max_width = 60,
        }
    },
    formatting = {
        fields = { 'abbr', 'menu', 'kind' },
        format = function(entry, item)
            local short_name = {
                nvim_lsp = 'LSP',
                nvim_lua = 'nvim'
            }

            local menu_name = short_name[entry.source.name] or entry.source.name

            item.menu = string.format('[%s]', menu_name)
            return item
        end,
    },
})

require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = {
        'tsserver',
        'rust_analyzer',
        'gopls',
        'eslint',
        'pylsp',
        'golangci_lint_ls',
        'templ',
        'html',
        'htmx',
        'tailwindcss',
        'lua_ls'
    },
    handlers = {
        lsp.default_setup,
    },
})


vim.filetype.add({
    extension = {
        templ = "templ"
    }
})

require('mason-nvim-dap').setup({
    ensure_installed = { 'delve' }
})

require('mason-null-ls').setup({
    ensure_installed = {
        "black",
        "flake8",
        "isort",
        "golangci-lint",
        "cfn-lint"
    }
})

local lspconfig = require("lspconfig")
lspconfig.pylsp.setup({
    pylsp = {
        black = { enabled = true },
        isort = { enabled = true },
    }
})

lspconfig.html.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "templ" },
})

lspconfig.htmx.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "templ" },
})

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.flake8,
    },
})


-- golang lint
local configs = require 'lspconfig/configs'

if not configs.golangcilsp then
    configs.golangcilsp = {
        default_config = {
            cmd = { 'golangci-lint-langserver' },
            root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
            init_options = {
                command = {
                    "golangci-lint",
                    "run",
                    "--enable-all",
                    "--disable",
                    "lll",
                    "--out-format",
                    "json",
                    "--issues-exit-code=1"
                },
            }
        },
    }
end

lspconfig.golangci_lint_ls.setup {
    filetypes = { 'go', 'gomod' }
}
