-- Filetype-specific tool checks
-- This module checks for required tools only when opening relevant files

local M = {}
local utils = require('core.utils')

-- Track which warnings have been shown to avoid repetition
local warned_tools = {}

-- Define tools needed for each filetype
local filetype_tools = {
  python = {
    { cmd = 'pyright', name = 'Pyright (Python LSP)', install = 'npm install -g pyright', optional = false },
    { cmd = 'ruff', name = 'Ruff (Python linter/formatter)', install = 'pip install ruff', optional = false },
  },
  lua = {
    { cmd = 'lua-language-server', name = 'Lua LSP', install = 'Install via :Mason', optional = false },
    { cmd = 'stylua', name = 'StyLua (Lua formatter)', install = 'brew install stylua', optional = false },
  },
  javascript = {
    { cmd = 'prettier', name = 'Prettier (formatter)', install = 'npm install -g prettier', optional = false },
    { cmd = 'eslint_d', name = 'ESLint daemon (linter)', install = 'npm install -g eslint_d', optional = true },
  },
  typescript = {
    { cmd = 'prettier', name = 'Prettier (formatter)', install = 'npm install -g prettier', optional = false },
    { cmd = 'eslint_d', name = 'ESLint daemon (linter)', install = 'npm install -g eslint_d', optional = true },
  },
  javascriptreact = {
    { cmd = 'prettier', name = 'Prettier (formatter)', install = 'npm install -g prettier', optional = false },
    { cmd = 'eslint_d', name = 'ESLint daemon (linter)', install = 'npm install -g eslint_d', optional = true },
  },
  typescriptreact = {
    { cmd = 'prettier', name = 'Prettier (formatter)', install = 'npm install -g prettier', optional = false },
    { cmd = 'eslint_d', name = 'ESLint daemon (linter)', install = 'npm install -g eslint_d', optional = true },
  },
  sh = {
    { cmd = 'bash-language-server', name = 'Bash LSP', install = 'npm install -g bash-language-server', optional = true },
    { cmd = 'shfmt', name = 'shfmt (shell formatter)', install = 'brew install shfmt', optional = true },
  },
  bash = {
    { cmd = 'bash-language-server', name = 'Bash LSP', install = 'npm install -g bash-language-server', optional = true },
    { cmd = 'shfmt', name = 'shfmt (shell formatter)', install = 'brew install shfmt', optional = true },
  },
  make = {
    { cmd = 'checkmake', name = 'checkmake (Makefile linter)', install = 'brew install checkmake', optional = true },
  },
  html = {
    { cmd = 'prettier', name = 'Prettier (formatter)', install = 'npm install -g prettier', optional = true },
  },
  css = {
    { cmd = 'prettier', name = 'Prettier (formatter)', install = 'npm install -g prettier', optional = true },
  },
  json = {
    { cmd = 'prettier', name = 'Prettier (formatter)', install = 'npm install -g prettier', optional = true },
  },
  yaml = {
    { cmd = 'prettier', name = 'Prettier (formatter)', install = 'npm install -g prettier', optional = true },
  },
  markdown = {
    { cmd = 'prettier', name = 'Prettier (formatter)', install = 'npm install -g prettier', optional = true },
  },
}

-- Check tools for a specific filetype
function M.check_filetype(ft)
  local tools = filetype_tools[ft]
  if not tools then
    return -- No tools defined for this filetype
  end

  local missing_required = {}
  local missing_optional = {}

  for _, tool in ipairs(tools) do
    local key = ft .. ':' .. tool.cmd
    if not warned_tools[key] then
      if not utils.command_exists(tool.cmd) then
        if tool.optional then
          table.insert(missing_optional, tool)
        else
          table.insert(missing_required, tool)
        end
        warned_tools[key] = true
      end
    end
  end

  -- Show warnings for missing required tools
  if #missing_required > 0 then
    local msg_parts = { string.format('Missing required tools for %s files:', ft) }
    for _, tool in ipairs(missing_required) do
      table.insert(msg_parts, string.format('  • %s: %s', tool.name, tool.install))
    end
    vim.notify(table.concat(msg_parts, '\n'), vim.log.levels.WARN, { title = 'LSP Tools' })
  end

  -- Show info for missing optional tools (less intrusive)
  if #missing_optional > 0 then
    local msg_parts = { string.format('Optional tools for %s files:', ft) }
    for _, tool in ipairs(missing_optional) do
      table.insert(msg_parts, string.format('  • %s: %s', tool.name, tool.install))
    end
    vim.notify(table.concat(msg_parts, '\n'), vim.log.levels.INFO, { title = 'LSP Tools' })
  end
end

-- Setup autocmd to check tools when opening files
function M.setup()
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('FiletypeToolCheck', { clear = true }),
    callback = function(args)
      -- Delay the check slightly to avoid interfering with LSP startup
      vim.defer_fn(function()
        M.check_filetype(args.match)
      end, 500)
    end,
  })

  -- Add a command to manually check tools for current filetype
  vim.api.nvim_create_user_command('CheckTools', function()
    local ft = vim.bo.filetype
    if ft and ft ~= '' then
      -- Clear warnings for this filetype to force re-check
      for key in pairs(warned_tools) do
        if key:match('^' .. ft .. ':') then
          warned_tools[key] = nil
        end
      end
      M.check_filetype(ft)
    else
      vim.notify('No filetype detected', vim.log.levels.WARN)
    end
  end, { desc = 'Check required tools for current filetype' })
end

return M
