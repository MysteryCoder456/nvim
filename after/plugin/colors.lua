function ColorMyPencils(color, airline)
    vim.opt.termguicolors = true

    color = color or "melange"
    vim.cmd.colorscheme(color)

    airline = airline or "zenburn"
    vim.cmd.AirlineTheme(airline)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.cmd.highlight("clear", "LineNr")
    vim.cmd.highlight("clear", "SignColumn")
end

ColorMyPencils()
