-- File manager
vim.keymap.set("n", "<leader>-", vim.cmd.Oil)

-- Undotree
vim.keymap.set("n", "<leader>u", require("undotree").toggle)

-- Harpoon
local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>A", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)

-- Trouble
vim.keymap.set("n", "<leader>vpa", function()
    require("trouble").toggle("custom_diagnostics")
end)
vim.keymap.set("n", "<leader>vpb", function()
    require("trouble").toggle("custom_diagnostics_buffer")
end)

-- Pane switching
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
