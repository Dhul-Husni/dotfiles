return {
  -- lsp
  { import = "lazyvim.plugins.extras.lang.ruby" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  -- Theme
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "dark",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
