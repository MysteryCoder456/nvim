require("trouble").setup {
    modes = {
        custom_mode = {
            mode = "diagnostics",
            preview = {
                type = "split",
                relative = "win",
                position = "right",
                size = 0.5,
            },
        },
    },
}

vim.keymap.set("n", "<leader>vcp", function()
    require("trouble").toggle("custom_mode")
end)
