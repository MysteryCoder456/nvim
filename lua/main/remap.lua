-- File manager
vim.keymap.set("n", "<leader>-", vim.cmd.Oil)

-- Undotree
vim.keymap.set("n", "<leader>u", require("undotree").toggle)

-- Pane switching
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
