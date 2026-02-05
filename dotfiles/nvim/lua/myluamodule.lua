local M = {}
local count = 0

function M.require_all(folder)
  local config_path = vim.fn.stdpath("config") .. "/lua/" .. folder:gsub("%.", "/")
  local files = vim.fn.readdir(config_path, [[v:val =~ '\.lua$']])
  for _, file in ipairs(files) do
    local module = folder .. "." .. file:gsub("%.lua$", "")
    require(module)
  end
end

return M

