return {
  -- lsp
  { import = "lazyvim.plugins.extras.lang.ruby" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  -- Theme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
      background = "dark",
    },
  },
}
