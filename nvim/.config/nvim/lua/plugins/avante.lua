return {
  "yetone/avante.nvim",
  version = false,
  build = "make",
  event = "VeryLazy",
  dependencies = {
    "nui.nvim",
    "zbirenbaum/copilot.lua",
    "ibhagwan/fzf-lua",
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>aa", "<cmd>AvanteAsk<CR>", desc = "avante: open" },
    { "<leader>aC", "<cmd>AvanteChat<CR>", desc = "avante: chat" },
    { "<leader>al", "<cmd>AvanteAsk position=left<CR>", desc = "avante: open on right panel" },
  },

  opts = {
    debug = false,
    provider = "claude",
    claude = {
      api_key_name = { "bw", "get", "notes", "anthropic-api-key" },
      max_tokens = 8192,
    },
    copilot = {
      model = "claude-3.5-sonnet",
      max_tokens = 8192,
    },
    openai = {
      -- api_key_name = "cmd:bw get notes oai-api-key",
      model = "gpt-4o-2024-08-06",
    },
    gemini = {
      -- api_key_name = "cmd:bw get notes gemini-api-key",
    },
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      support_paste_from_clipboard = true,
    },
    file_selector = {
      provider = "fzf",
    },
    mappings = {
      submit = { normal = "<CR>", insert = "<C-CR>" },
      suggestion = {
        accept = "<Tab>", -- Tab to accept
        next = "<C-n>", -- Ctrl+n for next (like in completion)
        prev = "<C-p>", -- Ctrl+p for previous (like in completion)
        dismiss = "<Esc>", -- Escape to dismiss
      },
    },
    windows = {
      position = "right",
      height = 4,
      sidebar_header = {
        align = "left", -- left, center, right for title
        rounded = false,
      },
      input = { prefix = "➜ " },
      edit = { border = vim.g.border, start_insert = false },
      ask = { start_insert = false, border = vim.g.border },
    },
  },
}
