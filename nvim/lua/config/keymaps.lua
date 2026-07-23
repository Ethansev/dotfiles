-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>sx", function()
    Snacks.picker.resume()
end, { noremap = true, silent = true, desc = "Resume" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center screen on down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center screen on up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search centering screen" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search centering screen" })
