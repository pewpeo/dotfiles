return {
  "nvim-mini/mini.nvim",
  version = false,
  config = function()
    local map = require("mini.map")
    map.setup({
      integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.diff(),
        map.gen_integration.diagnostic(),
      },
      symbols = {
        encode = map.gen_encode_symbols.dot("4x2"),
        scroll_line = "█",
        scroll_view = "┃",
      },
      window = {
        focusable = false,
        side = "right",
        show_integration_count = true,
        width = 10,
        winblend = 15,
        zindex = 10,
      },
    })
    -- Auto-open on buffer enter
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        MiniMap.open()
      end,
    })
  end,
  keys = {
    { "<leader>mm", "<cmd>lua MiniMap.toggle()<cr>", desc = "Toggle Mini Map" },
    { "<leader>mf", "<cmd>lua MiniMap.toggle_focus()<cr>", desc = "Toggle Mini Map Focus" },
    { "<leader>mr", "<cmd>lua MiniMap.refresh()<cr>", desc = "Refresh Mini Map" },
  },
}
