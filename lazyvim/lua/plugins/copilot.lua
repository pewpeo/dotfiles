return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  -- event = "InsertEnter",
  event = "BufReadPost",
  opts = {
    panel = {
      enabled = false, -- Disable panel, use inline suggestions only
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        -- accept = '<Tab>',
        -- accept_word = '<M-w>',
        -- accept_line = '<M-l>',
        -- next = '<M-]>',
        -- prev = '<M-[>',
        -- dismiss = '<C-]>',

        -- accept = false, -- handled by nvim-cmp / blink.cmp
        -- accept = "<leader><Right>",
        -- accept = "<Right>",
        accept_word = "<C-Right>",
        accept_line = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        -- dismiss = "<Esc>",
      },
    },
    -- nes = {
    --   enabled = true,
    -- keymap = {
    --   accept_and_goto = "<leader>p",
    --   accept = false,
    --   dismiss = "<Esc>",
    -- },
    -- },
    filetypes = {
      yaml = true,
      markdown = true,
      help = false,
      gitcommit = false,
      gitrebase = false,
      ["."] = false,
    },
  },
}
