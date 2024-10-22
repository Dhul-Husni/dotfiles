return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old and doesn't work on Windows
  build = ":TSUpdate",
  event = { "LazyFile", "VeryLazy" },
  lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treesitter** module to be loaded in time.
    -- Luckily, the only things that those plugins need are the custom queries, which we make available
    -- during startup.
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  keys = {
    { "<c-space>", desc = "Increment Selection" },
    { "<bs>", desc = "Decrement Selection", mode = "x" },
  },
  opts_extend = { "ensure_installed" },
  dependencies = { "RRethy/nvim-treesitter-endwise" },
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    endwise = {
      enable = true,
    },
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "bash",
      "go",
      "c",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "printf",
      "python",
      "ruby",
      "rust",
      "query",
      "regex",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
    matchup = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = { query = "@function.outer", desc = "select around function" },
          ["if"] = { query = "@function.inner", desc = "select inside function" },
          ["ac"] = { query = "@class.outer", desc = "select around class" },
          ["ic"] = { query = "@class.inner", desc = "select inside class" },
          ["al"] = { query = "@loop.outer", desc = "select around loop" },
          ["il"] = { query = "@loop.inner", desc = "select inside loop" },
          ["ab"] = { query = "@block.outer", desc = "select around block" },
          ["ib"] = { query = "@block.inner", desc = "select inside block" },
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["g+"] = { query = "@function.outer", desc = "go to next function" },
          ["gk+"] = { query = "@class.outer", desc = "go to next class" },
          ["gl+"] = { query = "@loop.outer", desc = "go to next loop" },
          ["gb+"] = { query = "@block.outer", desc = "go to next block" },
        },
        goto_previous_start = {
          ["g-"] = { query = "@function.outer", desc = "go to previous function" },
          ["gk-"] = { query = "@class.outer", desc = "go to previous class" },
          ["gl-"] = { query = "@loop.outer", desc = "go to previous loop" },
          ["gb-"] = { query = "@block.outer", desc = "go to previous block" },
        },
      },
      lsp_interop = {
        enable = true,
        border = "rounded",
        peek_definition_code = {
          ["gp"] = { query = "@function.outer", desc = "peek function definition" },
          ["gkp"] = { query = "@class.outer", desc = "peek class definition" },
        },
      },
    },
  },
  ---@param opts TSConfig
  config = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
    end
    require("nvim-treesitter.configs").setup(opts)
  end,
}
