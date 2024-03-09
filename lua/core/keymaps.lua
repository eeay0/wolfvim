local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<Space>", "", opts)
vim.g.mapleader = " "

-- Better up/down
map({ "n", "x", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })
map({ "n", "x", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true })

-- Move between windows
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
map("n", "<C-f>", "<C-w><C-w>", { desc = "Next window or Float", remap = true })

-- Resize windows
map("n", "<A-K>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<A-J>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<A-H>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<A-L>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Windows
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>ws", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>wv", "<C-W>v", { desc = "Split window right", remap = true })

-- Center the next search
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)
map("n", "*", "*zz", opts)
map("n", "#", "#zz", opts)
map("n", "g*", "g*zz", opts)
map("n", "g#", "g#zz", opts)

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Beginning and end of the line
map({ "n", "o", "x" }, "<s-l>", "g_", opts)
map({ "n", "o", "x" }, "<s-h>", "^", opts)

-- Navigate within insert mode
map("i", "<C-h>", "<Left>", opts)
map("i", "<C-j>", "<Down>", opts)
map("i", "<C-k>", "<Up>", opts)
map("i", "<C-l>", "<Right>", opts)

-- Copy whole file
-- map("n", "<C-a>", "<cmd> %y+ <CR>", opts)

-- Replace a word with yanked text
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', opts)

-- Navigate tab completion with <c-j> and <c-k>
map("c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', opts)
map("c", "<C-j>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', opts)

-- Open man page of the word
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- Open Lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Center/top/bottom current line
map("n", "<leader>c", "zz", opts)
map("n", "<leader>t", "zt", opts)
map("n", "<leader>b", "zb", opts)

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- Join lines
map("n", "J", "mzJ`z")

-- Scroll Half and center
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Delete to black hole
map({ "n", "v" }, "<leader>d", [["_d]])

-- Replace the word under the cursor.
map({ "n", "v" }, "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- File Explorer
map("n", "<A-f>", "<cmd> Lex <CR>", opts)

-- Change inside of "'([{
map("n", "<A-i>", "ci", opts)
