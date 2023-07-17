vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'


    -- ==================== THEMES ====================

    use {
        "nyoom-engineering/oxocarbon.nvim",
        as = "oxocarbon",
    }

    use { "catppuccin/nvim", as = "catppuccin", coroutine = function()
        require("catpuccin").setup()
    end }

    use { "savq/melange-nvim", as = "melange", }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons' }
    }


    -- ============= EDITOR FUNCTIONALITY =============

    use "tpope/vim-surround"
    use "jiangmiao/auto-pairs"
    use 'lukas-reineke/indent-blankline.nvim'
    use 'nvim-treesitter/playground'

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" }
    use { 'ThePrimeagen/harpoon', requires = 'nvim-lua/plenary.nvim' }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use 'mbbill/undotree'


    -- ===================== LSP ======================

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' }

    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
        end
    }

    use {
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    }

    -- use { 'codota/tabnine-nvim', run = "./dl_binaries.sh" }

    use "ray-x/lsp_signature.nvim"


    -- ==================== OTHERS ====================

    use 'andweeb/presence.nvim'
    use 'airblade/vim-gitgutter'
end)
