vim.g.lazyvim_prettier_needs_config = true

return
-- add pyright to lspconfig
{
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    inlay_hints = {
      enabled = false,
    },
    servers = {
      -- pyright will be automatically installed with mason and loaded with lspconfig
      pyright = {},
      clangd = {},
      rust_analyzer = {},
      biome = {},
    },
  },
}
