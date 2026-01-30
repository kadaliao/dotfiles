local M = {}

--- Check if a command is available in the system
function M.command_exists(cmd)
  local handle = io.popen('command -v "' .. cmd .. '" 2>/dev/null')
  local result = handle:read("*a"):gsub("%s+", "")
  handle:close()
  return result ~= ""
end

--- Check if a binary exists and notify user if missing
--- @param silent boolean? If true, don't show warnings
function M.require_command(cmd, friendly_name, install_instructions, silent)
  if not M.command_exists(cmd) then
    if not silent then
      local msg = string.format(
        "[LSP Info] %s is not installed. %s",
        friendly_name or cmd,
        install_instructions or ("Please install " .. cmd .. ".")
      )
      -- Use notify instead of echo for less intrusive warnings
      vim.notify(msg, vim.log.levels.INFO, { title = "LSP Tools" })
    end
    return false
  end
  return true
end

--- Silently check if command exists without warning
function M.check_command_silent(cmd)
  return M.command_exists(cmd)
end

--- Get installation command based on OS
function M.get_install_command(tool_name)
  local os_name = vim.loop.os_uname().sysname
  if os_name == "Darwin" then
    return "brew install " .. tool_name
  elseif os_name == "Linux" then
    -- Detect package manager
    if M.command_exists("apt-get") then
      return "sudo apt-get install " .. tool_name
    elseif M.command_exists("yum") then
      return "sudo yum install " .. tool_name
    elseif M.command_exists("pacman") then
      return "sudo pacman -S " .. tool_name
    else
      return "Install " .. tool_name .. " using your system's package manager"
    end
  else
    return "Install " .. tool_name .. " using your system's package manager"
  end
end

--- Attempt to install a tool automatically
function M.attempt_install(tool_name)
  local install_cmd = M.get_install_command(tool_name)
  vim.api.nvim_echo({{"Attempting to install " .. tool_name .. "..."}, {"\nCommand: " .. install_cmd}}, false, {})
  
  -- Ask for confirmation before proceeding
  local choice = vim.fn.input("Proceed with installation? (y/N): ")
  if choice:lower() == 'y' or choice:lower() == 'yes' then
    local result = vim.fn.system(install_cmd)
    if vim.v.shell_error == 0 then
      vim.api.nvim_echo({{"Successfully installed " .. tool_name}}, true, {})
      return true
    else
      vim.api.nvim_echo({{"Failed to install " .. tool_name}, {"Error: " .. result}}, true, {})
      return false
    end
  else
    vim.api.nvim_echo({{"Installation cancelled."}}, true, {})
    return false
  end
end

return M