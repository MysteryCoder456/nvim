function ColorMyPencils(color, airline)
    color = color or "oxocarbon"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    airline = airline or "night_owl"
    vim.cmd.AirlineTheme(airline)
end

ColorMyPencils()
