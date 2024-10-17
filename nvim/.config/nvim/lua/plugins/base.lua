return {
  -- lsp
  { import = "lazyvim.plugins.extras.lang.ruby" },

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
