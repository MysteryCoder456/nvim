local flutter = require("flutter-tools")

flutter.setup({
    ui = {
        border = "rounded",
    },
    decorations = {
        statusline = {
            app_version = false,
            device = false,
        }
    },
})
