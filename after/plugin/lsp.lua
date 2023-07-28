local lsp = require('lsp-zero')
local lspconfig = require("lspconfig")

lsp.preset('recommended')

lsp.ensure_installed({
    "pyright",
    "rust_analyzer",
    "emmet_ls",
    "ruff_lsp",
})
lspconfig.sourcekit.setup {}
lspconfig.rome.setup {
    cmd = { "--indent-style", "space", "--indent-size", "4" }
}
lspconfig.gdscript.setup {}

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.set_preferences({
    sign_icons = {}
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

--lsp.on_attach(function(client, bufnr)
--    local opts = { buffer = bufnr, remap = false }

--    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--    vim.keymap.set("n", "F", function() vim.lsp.buf.format() end, opts)
--    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
--    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--end)

vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)
vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)

lsp.setup()

local null_ls = require("null-ls")
local null_opts = lsp.build_options('null-ls', {})

null_ls.setup {
    on_attach = function(client, bufnr)
        null_opts.on_attach(client, bufnr)
    end,
    sources = {
        -- TODO: Move all these to lspconfig sources
        null_ls.builtins.diagnostics.djlint,
        null_ls.builtins.diagnostics.swiftlint,
        null_ls.builtins.formatting.black.with({ extra_args = { "-l", "79" } }),
        null_ls.builtins.formatting.gdformat,
        null_ls.builtins.formatting.djhtml,
        null_ls.builtins.formatting.swiftformat,
    }
}

vim.diagnostic.config {
    virtual_text = true,
}

-- Format on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
