local M = {}

local utils = require('core.utils')

function M.check()
  vim.health.start('Neovim Configuration Health Check')
  
  -- Check essential commands
  local essential_commands = {
    { 'git', 'Required for plugin management and git operations' },
    { 'nvim', 'Required for Neovim itself' },
  }
  
  for _, cmd_info in ipairs(essential_commands) do
    if utils.command_exists(cmd_info[1]) then
      vim.health.ok(cmd_info[1] .. ' is available')
    else
      vim.health.error(cmd_info[1] .. ' is not available', cmd_info[2])
    end
  end
  
  -- Check LSP-related commands
  vim.health.info('Checking LSP-related tools...')
  local lsp_commands = {
    { 'pylsp', 'Python LSP Server' },
    { 'pyright', 'Alternative Python LSP Server' },
    { 'lua-language-server', 'Lua LSP Server' },
    { 'bash-language-server', 'Bash LSP Server' },
    { 'docker-langserver', 'Docker LSP Server' },
  }
  
  for _, cmd_info in ipairs(lsp_commands) do
    if utils.command_exists(cmd_info[1]) then
      vim.health.ok(cmd_info[1] .. ' is available (' .. cmd_info[2] .. ')')
    else
      vim.health.warn(cmd_info[1] .. ' is not available (' .. cmd_info[2] .. ')', 'Install with: ' .. utils.get_install_command(cmd_info[1]))
    end
  end
  
  -- Check formatting/linting tools
  vim.health.info('Checking formatting and linting tools...')
  local formatting_commands = {
    { 'prettier', 'JavaScript/TypeScript/JSON formatter' },
    { 'stylua', 'Lua formatter' },
    { 'eslint_d', 'JavaScript/TypeScript linter daemon' },
    { 'shfmt', 'Shell script formatter' },
    { 'checkmake', 'Makefile linter' },
    { 'ruff', 'Fast Python linter/formatter' },
    { 'black', 'Python formatter' },
    { 'flake8', 'Python linter' },
    { 'isort', 'Python import sorter' },
  }
  
  for _, cmd_info in ipairs(formatting_commands) do
    if utils.command_exists(cmd_info[1]) then
      vim.health.ok(cmd_info[1] .. ' is available (' .. cmd_info[2] .. ')')
    else
      vim.health.warn(cmd_info[1] .. ' is not available (' .. cmd_info[2] .. ')', 'Install with: ' .. utils.get_install_command(cmd_info[1]))
    end
  end
  
  vim.health.info('Run :checkhealth lua for more detailed information about your Neovim configuration.')
end

return M