vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- paste without overiding buffer
vim.keymap.set("x", "<leader>p", "\"_dP")
