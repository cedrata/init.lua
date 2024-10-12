local lsp = require("lsp-zero")

lsp.preset("recommended")

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

-- custom formatting to allow kids with special needs e.g. templ file
-- to be formatted properly each time without any conflicts in the buffer.
local custom_format = function()
    if vim.bo.filetype == "templ" then
        local bufnr = vim.api.nvim_get_current_buf()
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local cmd = "templ fmt " .. vim.fn.shellescape(filename)

        vim.fn.jobstart(cmd, {
            on_exit = function()
                -- Reload the buffer only if it's still the current buffer
                if vim.api.nvim_get_current_buf() == bufnr then
                    vim.cmd('e!')
                end
            end,
        })
    else
        vim.lsp.buf.format()
    end
end

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr, exclude = { '<F3>' } })
    vim.keymap.set("n", "<leader>ff", custom_format, opts)
end)

-- lsp.configure('templ', {
--     lsp.configure('html', {
--         on_attach = function(client, bufnr)
--             -- Only disable formatting for .templ files
--             local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
--             if filetype == 'templ' and client.name == 'html' then
--                 client.server_capabilities.documentFormattingProvider = false
--             end
--         end,
--     })
-- })

lsp.setup()

require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = {
        'rust_analyzer',
        'gopls',
        'eslint',
        'pyright',
        'golangci_lint_ls',
        'templ',
        'html',
        'htmx',
        'tailwindcss',
        'lua_ls',
        'ruff_lsp'
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
        "isort",
        "golangci-lint",
        "blade-formatter"
    }
})

local lspconfig = require("lspconfig")
local ruff_on_attach = function(client, _)
    if client.name == 'ruff_lsp' then
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
    end
end

lspconfig.ruff_lsp.setup {
    on_attach = ruff_on_attach,
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
        }
    }
}

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

lspconfig.pyright.setup({
    on_attach = on_attach,
    settings = {
        pyright = {
            disableOrganizeImports = true,
            diagnosticMode = "off"
        },
    }
})

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.blade_formatter,
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

vim.diagnostic.config({
    virtual_text = true
})
