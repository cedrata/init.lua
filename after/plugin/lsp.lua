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
        'pylsp'
    },
    handlers = {
        lsp.default_setup,
    },
})

require('mason-nvim-dap').setup({
    ensure_installed = {'delve'}
})

lspconfig = require("lspconfig")
lspconfig.pylsp.setup({
    pylsp = {
        black = {enabled = true},
    }
})

require('mason-null-ls').setup({
    ensure_installed = { "black", "pylint" }
})

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black.with({
      condition = function(utils)
        return utils.root_has_file('pyproject.toml') -- change file extension if you use something else
      end,
    }),
    null_ls.builtins.diagnostics.pylint.with {
      condition = function(utils)
        return utils.root_has_file({'pylintrc', '.pylintrc'})
      end,
      -- extra_args = -- some function to generate the required config
    },
  },
})
