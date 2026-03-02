return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<c-/>", false },
      { "<c-/>", false, mode = "t" },
      {
        "<c-#>",
        function()
          Snacks.terminal()
        end,
        desc = "Toggle Terminal",
      },
      { "<c-#>", "<cmd>close<cr>", desc = "Hide Terminal", mode = "t" },
    },
    opts = {
      terminal = {
        win = {
          style = "float",
          border = "rounded",
          width = 0.9,
          height = 0.9,
        },
      },
      picker = {
        hidden = true,
        ignored = false,
        sources = {
          files = {
            hidden = true, -- Show hidden/dotfiles
            ignored = false,
          },
        },
        layouts = {
          default = {
            layout = {
              box = "horizontal",
              width = 0.8,
              min_width = 120,
              height = 0.8,
              {
                box = "vertical",
                border = "rounded",
                title = "{title} {live} {flags}",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              { win = "preview", title = "{preview}", border = "rounded", width = 0.6 },
            },
          },
        },
      },
    },
  },
}
