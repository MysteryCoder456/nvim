vim.g.mapleader = " "

vim.keymap.set("n", "<leader>-", vim.cmd.Oil)

-- Pane switching
vim.keymap.set("n", "<leader>a", "<C-w>h")
vim.keymap.set("n", "<leader>s", "<C-w>j")
vim.keymap.set("n", "<leader>w", "<C-w>k")
vim.keymap.set("n", "<leader>d", "<C-w>l")
