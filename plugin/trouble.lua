require("trouble").setup {
    modes = {
        custom_diagnostics = {
            mode = "diagnostics",
            preview = {
                type = "split",
                relative = "win",
                position = "right",
                size = 0.4,
            },
        },
        custom_diagnostics_buffer = {
            mode = "custom_diagnostics",
            filter = { buf = 0 },
        }
    },
}
