require("trouble").setup {
    modes = {
        custom_mode = {
            mode = "diagnostics",
            preview = {
                type = "split",
                relative = "win",
                position = "right",
                size = 0.3,
            },
        },
    },
}

vim.keymap.set("n", "<leader>vcp", function()
    require("trouble").open("custom_mode")
end)
