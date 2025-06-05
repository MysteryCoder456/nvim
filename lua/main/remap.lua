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
vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end)
vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end)
vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end)
vim.keymap.set("n", "<leader>9", function() harpoon:list():select(9) end)
vim.keymap.set("n", "<leader>0", function() harpoon:list():select(10) end)

-- Trouble
vim.keymap.set("n", "<leader>vpa", function()
    require("trouble").toggle("custom_diagnostics")
end)
vim.keymap.set("n", "<leader>vpb", function()
    require("trouble").toggle("custom_diagnostics_buffer")
end)

-- TODO comments
vim.keymap.set("n", "<C-f><C-t>", vim.cmd.TodoTelescope)
vim.keymap.set("n", "<leader>vpt", function()
    require("trouble").toggle("todo")
end)

-- Pane switching
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Copilot
vim.keymap.set("n", "<leader>cp", vim.cmd.CopilotChatToggle)
