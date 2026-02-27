return {
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    dependencies = { "lewis6991/gitsigns.nvim" },
    opts = {
      -- show = true,
      -- throttle_ms = 100,
      handle = {
        text = " ",
        blend = 0, -- 30
        -- highlight = "ScrollbarHandle",
      },
      -- marks = {
      --   Cursor = { text = "—", highlight = "ScrollbarCursor" },
      --   Search = { text = { "—", "⫿" }, highlight = "ScrollbarSearch" },
      --   Error = { text = { "—", "⫿" }, highlight = "ScrollbarError" },
      --   Warn = { text = { "—", "⫿" }, highlight = "ScrollbarWarn" },
      --   Info = { text = { "—", "⫿" }, highlight = "ScrollbarInfo" },
      --   Hint = { text = { "—", "⫿" }, highlight = "ScrollbarHint" },
      --   Misc = { text = { "—", "⫿" }, highlight = "ScrollbarMisc" },
      -- },
      handlers = {
        gitsigns = true,
      },
    },
  },
}
