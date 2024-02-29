local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- go over wrapped lines
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- search operations
keymap("n", "<C-s>", ":nohlsearch<CR>", { desc = "Remove search highlights", noremap = true, silent = true })

-- chmod +x to existing file
keymap("n", "<leader>fx", "<cmd>!chmod +x %<CR>", { desc = "Set current find chmod +x", noremap = true, silent = true })

-- remove linebreak, and append the next line to the end of the current line
keymap("n", "J", "mzJ`z", opts)

-- keep cursor in the middle of the screen when jumping half-pages with C-u and C-d
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- move selected line up and down and keep indentation
-- TODO: im losing the J, K functionality, need to rethink it
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- keep cursor in the middle of the screen when jumping between search results
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- paste without yanking
keymap("x", "p", '"_dP', opts)

-- disable Q
keymap("n", "Q", "<nop>", opts)

-- quickfix actions
keymap("n", "<leader>q", function() -- toggle quickfix
    if vim.bo.filetype == "qf" then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end, opts)
keymap("n", "]q", ":cnext<CR>", opts) -- next quickfix
keymap("n", "[q", ":cprev<CR>", opts) -- previous quickfix

-- new sessionizer
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts)

-- copy selected text in visual mode to clip board
keymap("v", "<leader>y", [["+y]], opts)

-- copy entire file to clipboard
keymap("n", "<leader>y", ":%y+<CR>", opts)

-- source current file
keymap("n", "<leader><leader>x", ":w<CR>:source %<CR>", opts)
