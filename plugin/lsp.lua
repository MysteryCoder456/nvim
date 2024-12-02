local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp_on_attach = function(client, bufnr, async)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)

    -- Format on save
    vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format({ async = async })]]

    -- Show function signature when calling functions
    vim.cmd [[
    augroup lsp
    autocmd!
    autocmd CursorHoldI *.* lua vim.lsp.buf.signature_help()
    augroup END
    ]]

    -- Inlay hints
    vim.lsp.inlay_hint.enable(true)
end

require("mason").setup {}
require("mason-lspconfig").setup {
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "ruff",
        "clangd",
        "cmake",
        "glsl_analyzer",
        "html",
        "cssls",
        "emmet_ls", "tailwindcss",
    },
}
require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {
            on_attach = function(client, bufnr) lsp_on_attach(client, bufnr, true) end,
            capabilities = cmp_capabilities,
        }
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["rust_analyzer"] = function ()
    --     require("rust-tools").setup {}
    -- end
}
-- require("lspconfig")

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup {
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"

            return kind
        end,
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

local null_ls = require("null-ls")
null_ls.setup {
    on_attach = function(client, bufnr) lsp_on_attach(client, bufnr, false) end,
    sources = {
        null_ls.builtins.formatting.black.with({ extra_args = { "-l", "79" } }),
        null_ls.builtins.formatting.djlint.with({ filetypes = { "html", "django", "htmldjango" } }),
        null_ls.builtins.formatting.prettierd.with({ filetypes = { "jsonc", "json", "typescript", "astro", "javascriptreact", "javascript", "typescriptreact", "scss", "vue", "handlebars", "graphql", "svelte", "markdown", "css", "yaml", "less", "markdown.mdx" } }), -- All supported files except html
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.diagnostics.djlint.with({ filetypes = { "html", "django", "htmldjango" } }),
    },
}

-- Hover window borders
local _border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = _border
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        focus = false, border = _border
    }
)

-- Virtual text errors
vim.diagnostic.config {
    virtual_text = true,
    float = { border = _border }
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
