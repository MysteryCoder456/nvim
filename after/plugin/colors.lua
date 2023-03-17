function ColorMyPencils(color, airline)
    color = color or "catppuccin-mocha"
    vim.cmd.colorscheme(color)

    airline = airline or "base16_outrun_dark"
    vim.cmd.AirlineTheme(airline)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.cmd.highlight("clear", "LineNr")
    vim.cmd.highlight("clear", "SignColumn")
end

ColorMyPencils()
