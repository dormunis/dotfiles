vim.keymap.set("n", "<leader>s", function()
end, { desc = "Search within file" })

vim.keymap.set("n", "<leader>c", function()
end, { desc = "Code" })


vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = '[S]earch [R]eplace current word' })

-- chmod +x to existing file
vim.keymap.set("n", "<leader>fx", "<cmd>!chmod +x %<CR>", { silent = true, desc = 'Set current find chmod +x' })

-- remove highlights from search
vim.keymap.set("n", "<leader>sh", ":nohlsearch<CR>", { desc = 'Remove [S]earch [H]ighlights' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- move selected line up and down and keep indentation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- remove linebreak, and append the next line to the end of the current line
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor in the middle of the screen when jumping half-pages with C-u and C-d
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep cursor in the middle of the screen when jumping between search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- B to go to the beginning of the line (start of the first word)
vim.keymap.set("n", "B", "^")
-- E to get to the end of the line
vim.keymap.set("n", "E", "$")

-- disable Q
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
