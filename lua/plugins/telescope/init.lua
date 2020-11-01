local vim = vim

local opts = {
    noremap = true,
    silent = true
}
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require'telescope.builtin'.buffers{ shorten_path = true }<CR>",
    opts)
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require'plugins/telescope/find_files'.find_files{}<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fgf", "<cmd>lua require'telescope.builtin'.git_files{ shorten_path = true }<CR>",
    opts)
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>lua require'telescope.builtin'.oldfiles{}<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fw", "<cmd>lua require'telescope.builtin'.grep_string{}<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fm", "<cmd>lua require'telescope.builtin'.marks{}<CR>", opts)

vim.api.nvim_set_keymap("n", "<leader>flr", "<cmd>lua require'telescope.builtin'.lsp_references{}<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fld", "<cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>flw", "<cmd>lua require'telescope.builtin'.lsp_workspace_symbols{}<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ft", "<cmd>lua require'telescope.builtin'.treesitter{}<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fch", "<cmd>lua require'telescope.builtin'.command_history{}<CR>", opts)

vim.api.nvim_set_keymap("n", "<leader>/", "<cmd>lua require'telescope.builtin'.live_grep{ shorten_path = true }<CR>",
    opts)
vim.api
    .nvim_set_keymap("n", "<leader>fcb", "<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fcc", "<cmd>lua require'telescope.builtin'.colorscheme{}<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fgh", "<cmd>lua require'telescope.builtin'.help_tags{}<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fm", "<cmd>lua require'telescope.builtin'.man_pages{}<CR>", opts)
