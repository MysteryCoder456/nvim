require("presence"):setup({
    -- General options
    auto_update         = true,
    neovim_image_text   = "Do you even Vim bro?",
    main_image          = "file",
    client_id           = "793271441293967371",
    log_level           = nil,
    debounce_timeout    = 10,
    enable_line_number  = false,
    blacklist           = {},
    buttons             = true,
    file_assets         = {
        asm = {
            "Assembly",
            "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.pinimg.com%2Foriginals%2F8c%2Fb1%2F8c%2F8cb18c72082d13eb581cf6d452e8e266.png&f=1&nofb=1&ipt=234567d21c79aa9bd8d5f65235956dd34a3c251e20f60d468b4a7ff12cfb62f4&ipo=images"
        }
    },
    show_time           = true,

    -- Rich Presence text options
    editing_text        = "Editing %s",
    file_explorer_text  = "Browsing %s",
    git_commit_text     = "Committing changes",
    plugin_manager_text = "Managing plugins",
    reading_text        = "Reading %s",
    workspace_text      = "Working on %s",
    line_number_text    = "Line %s out of %s",
})
