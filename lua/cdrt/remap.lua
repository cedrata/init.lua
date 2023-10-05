vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- paste without overiding buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
