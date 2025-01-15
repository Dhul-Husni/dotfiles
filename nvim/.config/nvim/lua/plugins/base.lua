return {
  -- lsp
  { import = "lazyvim.plugins.extras.lang.ruby" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  -- extras
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  { import = "lazyvim.plugins.extras.coding.luasnip" },
  { import = "lazyvim.plugins.extras.ai.copilot" },
  { import = "lazyvim.plugins.extras.ai.copilot-chat" },
  { import = "lazyvim.plugins.extras.lang.elixir" },
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
  {
    "saghen/blink.cmp",
    opts = {
      signature = { enabled = true },
      keymap = {
        preset = "super-tab",
      },
    },
  },
}
