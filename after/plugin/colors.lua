function ColorMyPencils(color, lualine)
    vim.opt.termguicolors = true

    color = color or "kanagawa"
    vim.cmd.colorscheme(color)

    lualine = lualine or "kanagawa"
    require("lualine").setup {
        option = {
            theme = lualine
        }
    }

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.cmd.highlight("clear", "LineNr")
    vim.cmd.highlight("clear", "SignColumn")
end

ColorMyPencils()
