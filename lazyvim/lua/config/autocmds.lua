-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- biome
-- https://github.com/biomejs/biome/discussions/9307
local function apply_code_action_sync(bufnr, client, action_kind)
  local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
  params.context = { only = { action_kind }, diagnostics = {} }

  local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 3000)

  if not results then
    return
  end

  for _, res in pairs(results) do
    for _, action in pairs(res.result or {}) do
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
      elseif action.command then
        client:exec_cmd(action.command)
      end
    end
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client and client.name == "biome" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          apply_code_action_sync(bufnr, client, "source.organizeImports")
          apply_code_action_sync(bufnr, client, "source.fixAll")
        end,
      })
    end
  end,
})
