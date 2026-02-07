vim.g.clipboard = {
  name = "win32yank-wsl",
  copy = {
    ["+"] = "/mnt/c/win32yank/win32yank.exe -i --crlf",
    ["*"] = "/mnt/c/win32yank/win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "/mnt/c/win32yank/win32yank.exe -o --lf",
    ["*"] = "/mnt/c/win32yank/win32yank.exe -o --lf",
  },
  cache_enabled = false,
}

