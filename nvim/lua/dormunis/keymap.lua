-- search operations
vim.keymap.set("n", "<C-s>", ":nohlsearch<CR>", { desc = 'Remove search highlights' })

-- chmod +x to existing file
vim.keymap.set("n", "<leader>fx", "<cmd>!chmod +x %<CR>", { silent = true, desc = 'Set current find chmod +x' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- remove linebreak, and append the next line to the end of the current line
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor in the middle of the screen when jumping half-pages with C-u and C-d
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- move selected line up and down and keep indentation
-- TODO: im losing the J, K functionality, need to rethink it
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor in the middle of the screen when jumping between search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

-- disable Q
vim.keymap.set("n", "Q", "<nop>")

-- new sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- copy selected text in visual mode to clip board
vim.keymap.set("v", "<leader>y", [["+y]])
