-- neovim/plugins/lsp.lua

local on_attach = function(_, bufnr)

  local bufmap = function(keys, func)
    vim.keymap.set('n', keys, func, { buffer = bufnr })
  end

  bufmap('<leader>r', vim.lsp.buf.rename)
  bufmap('<leader>a', vim.lsp.buf.code_action)

  bufmap('gd', vim.lsp.buf.definition)
  bufmap('gD', vim.lsp.buf.declaration)
  bufmap('gI', vim.lsp.buf.implementation)
  bufmap('<leader>D', vim.lsp.buf.type_definition)

  bufmap('gr', require('telescope.builtin').lsp_references)
  bufmap('<leader>fs', require('telescope.builtin').lsp_document_symbols)
  bufmap('<leader>fS', require('telescope.builtin').lsp_dynamic_workspace_symbols)

  bufmap('K', vim.lsp.buf.hover)
  bufmap('<leader>e', vim.diagnostic.open_float)

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Custom floating window border
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or {
    {"╭", "FloatBorder"},
    {"─", "FloatBorder"},
    {"╮", "FloatBorder"},
    {"│", "FloatBorder"},
    {"╯", "FloatBorder"},
    {"─", "FloatBorder"},
    {"╰", "FloatBorder"},
    {"│", "FloatBorder"},
  }
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Language Servers
-- Split LSP_PATH at `:`, and attempt to connect to each language server

local lsp_path = os.getenv("LSP_PATH") or ""
for server in string.gmatch(lsp_path, "([^:]+)") do
  require('lspconfig')[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Lua Language Server
-- require('lspconfig').lua_ls.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     root_dir = function()
--         return vim.loop.cwd()
--     end,
--     cmd = { "lua-lsp" },
--     settings = {
--         Lua = {
--             workspace = { checkThirdParty = false },
--             telemetry = { enable = false },
--         },
--     }
-- }
