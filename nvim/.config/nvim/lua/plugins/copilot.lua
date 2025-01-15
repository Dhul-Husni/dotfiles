local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvement.",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
  SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>a", group = "ai" },
      },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    cmd = "CopilotChat",
    dependencies = {
      { "ibhagwan/fzf-lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_follow_cursor = true,
        question_header = "   " .. user .. " ",
        answer_header = "   Copilot ",
        error_header = "## Error ",
        prompts = prompts,
        window = {
          width = 0.4,
        },
        mappings = {
          complete = {
            detail = "Use @<Tab> or /<Tab> for options.",
            insert = "<Tab>",
          },
          close = {
            normal = "<CR>",
            insert = "<C-CR>",
          },
          reset = {
            normal = "<C-x>",
            insert = "<C-x>",
          },
          submit_prompt = {
            normal = "<CR>",
            insert = "<CR>",
          },
          accept_diff = {
            normal = "<C-y>",
            insert = "<C-y>",
          },
          show_help = {
            normal = "g?",
          },
        },
      }
    end,
    config = function(_, opts)
      local chat = require("CopilotChat")
      chat.setup(opts)

      local select = require("CopilotChat.select")
      vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
        chat.ask(args.args, { selection = select.visual })
      end, { nargs = "*", range = true })

      -- Custom buffer for CopilotChat
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false

          -- Set filetype to markdown
          local ft = vim.bo.filetype
          if ft == "copilot-chat" then
            vim.bo.filetype = "markdown"
          end
        end,
      })
    end,
    keys = {
      -- Main menu
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },

      -- Toggle and core functions
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle Chat",
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear Chat",
      },

      -- Quick chat and prompts
      {
        "<leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end,
        desc = "Quick Chat",
      },
      {
        "<leader>ap",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "Prompt Actions",
      },

      -- Code related commands
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain Code" },
      { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate Tests" },
      { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review Code" },
      { "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "Refactor Code" },
      { "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "Better Naming" },

      -- Visual mode specific
      {
        "<leader>av",
        ":CopilotChatVisual",
        mode = "x",
        desc = "Open in Visual Split",
      },

      -- Additional features
      { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>", desc = "Debug Info" },
      { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "Fix Diagnostic" },
      { "<leader>al", "<cmd>CopilotChatReset<cr>", desc = "Clear History" },

      -- Models and agents
      { "<leader>a?", "<cmd>CopilotChatModels<cr>", desc = "Select Models" },
      { "<leader>ag", "<cmd>CopilotChatAgents<cr>", desc = "Select Agents" },
    },
  },
}
