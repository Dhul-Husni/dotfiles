-- LSP Server to use for Ruby.
vim.g.lazyvim_ruby_lsp = "solargraph"
vim.g.lazyvim_ruby_formatter = "rubocop"

-- nerd fonts
vim.g.have_nerd_font = true

vim.treesitter.language.register("bash", "cheat")

-- copilot
vim.g.copilot_node_command = "~/.nvm/versions/node/v18.20.4/bin/node"
