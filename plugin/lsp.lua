local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp_on_attach = function(client, bufnr, async)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({
            async = async,
            filter = function(c) return c.name ~= "ts_ls" end
        })
    end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)

    -- Format on save
    vim.cmd [[ autocmd BufWritePre * lua vim.lsp.buf.format({ async = async, filter = function(c) return c.name ~= "ts_ls" end }) ]]

    -- Inlay hints
    vim.lsp.inlay_hint.enable(true)
end

-- Setup LSP handlers
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        lsp_on_attach(client, bufnr, true)
    end,
})

vim.lsp.config("*", {
    capabilities = cmp_capabilities,
})

vim.lsp.config.jdtls = {
    capabilities = cmp_capabilities,
    single_file_support = true,
}
vim.lsp.enable("jdtls")

vim.lsp.config.sourcekit = {
    cmd = { "sourcekit-lsp" },
    filetypes = { "swift", "objective-c", "objective-cpp" },
    root_markers = { "Package.swift", ".git" },
    capabilities = cmp_capabilities,
}
vim.lsp.enable("sourcekit")

require("mason").setup {}
require("mason-lspconfig").setup {
    automatic_enable = true,
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "ruff",
        "html",
        "cssls",
        "emmet_ls",
        "tailwindcss",
    },
}

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local lspkind = require("lspkind")
cmp.setup {
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
    },
    window = {
        completion = cmp.config.window.bordered({ border = 'rounded' }),
        documentation = cmp.config.window.bordered({ border = 'rounded' }),
    },
    formatting = {
        fields = { "icon", "abbr", "kind", "menu" },
        format = lspkind.cmp_format({
            maxwidth = {
                -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                -- can also be a function to dynamically calculate max width such as
                -- menu = function() return math.floor(0.45 * vim.o.columns) end,
                menu = 50,            -- leading text (labelDetails)
                abbr = 50,            -- actual suggestion item
            },
            ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
                return vim_item
            end
        }),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<CR>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
        ["<C-Space>"] = cmp.mapping.complete(),
    })
}
cmp.event:on("menu_opened", function()
    vim.b.copilot_suggestion_hidden = true
end)
cmp.event:on("menu_closed", function()
    vim.b.copilot_suggestion_hidden = false
end)

local null_ls = require("null-ls")
null_ls.setup {
    on_attach = function(client, bufnr) lsp_on_attach(client, bufnr, false) end,
    sources = {
        null_ls.builtins.formatting.djlint.with({ filetypes = { "html", "django", "htmldjango" } }),
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.diagnostics.djlint.with({ filetypes = { "html", "django", "htmldjango" } }),
    },
}

vim.diagnostic.config {
    virtual_text = true,
}

-- HACK: workaround for neovim issue #30985
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end

require("flutter-tools").setup {
    decorations = {
        statusline = {
            device = true,
        },
    },
    lsp = {
        on_attach = function(client, bufnr) lsp_on_attach(client, bufnr, true) end,
    },
}
