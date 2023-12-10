-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { "ellisonleao/gruvbox.nvim" }
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }
    use {
        "/jose-elias-alvarez/null-ls.nvim",
        "jay-babu/mason-null-ls.nvim"
    }
    use {
        'mfussenegger/nvim-dap',
        "jay-babu/mason-nvim-dap.nvim"
    }
    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            -- adapters
            "nvim-neotest/neotest-go",
        }
    }
    use({
        "andythigpen/nvim-coverage",
        requires = "nvim-lua/plenary.nvim",
        -- Optional: needed for PHP when using the cobertura parser
        -- rocks = { 'lua-xmlreader' },
        config = function()
            require("coverage").setup()
        end,
    })
    use {
        'nvim-lualine/lualine.nvim',
        requires = ({ 
            'nvim-tree/nvim-web-devicons', 
            opt = true 
        })
    }
end)
