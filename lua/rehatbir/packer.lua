-- Install packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"


    -- ==================== THEMES ====================

    use {
        "nyoom-engineering/oxocarbon.nvim",
        as = "oxocarbon",
    }

    use {
        "catppuccin/nvim",
        as = "catppuccin",
        coroutine = function()
            require("catpuccin").setup()
        end
    }

    use { "savq/melange-nvim", as = "melange", }

    use "rebelot/kanagawa.nvim"

    use {
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons" }
    }


    -- ============= EDITOR FUNCTIONALITY =============

    use "tpope/vim-surround"
    use "jiangmiao/auto-pairs"
    use "lukas-reineke/indent-blankline.nvim"

    use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" }
    use { "ThePrimeagen/harpoon", requires = "nvim-lua/plenary.nvim" }

    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use {
        "nvim-treesitter/nvim-treesitter-context",
        requires = { "nvim-treesitter/nvim-treesitter" }
    }

    use {
        "nvim-telescope/telescope.nvim", branch = "0.1.x",
        requires = { "nvim-lua/plenary.nvim" }
    }

    use "mbbill/undotree"
    use "norcalli/nvim-colorizer.lua"


    -- ===================== LSP ======================

    use {
        "VonHeikemen/lsp-zero.nvim",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        }
    }

    use { "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim" }

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


    -- ==================== OTHERS ====================

    use {
        "Exafunction/codeium.vim",
        config = function()
            vim.keymap.set('i', '<C-y>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
            vim.keymap.set('i', '<c-n>', function() return vim.fn['codeium#CycleCompletions'](1) end,
                { expr = true, silent = true })
            vim.keymap.set('i', '<c-p>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
                { expr = true, silent = true })
            vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
        end
    }
    use "andweeb/presence.nvim"
    use "airblade/vim-gitgutter"

    use({
        "utilyre/barbecue.nvim",
        tag = "*",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        after = "nvim-web-devicons",       -- keep this if you're using NvChad
        config = function()
            require("barbecue").setup()
        end,
    })

    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use {
        "stevearc/oil.nvim",
        requires = { "nvim-tree/nvim-web-devicons" }
    }

    -- Sync packer packages
    if packer_bootstrap then
        require('packer').sync()
    end
end)
