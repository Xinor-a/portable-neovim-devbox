return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "master",
  lazy = false,
  config = function()
    require("nvim-treesitter.configs").setup(
      {
        -- A list of parser names, or "all" (the listed parsers MUST always be installed)
        ensure_installed = { 
          "c", "c_sharp", "cpp", "cmake", "css", "csv",
          "dockerfile",
          "git_config", "git_rebase", "gitignore",
          "html",
          "ini",
          "java", "javascript",
          "latex", "lua",
          "markdown", "mermaid",
          "powershell", "python",
          "rust",
          "tmux", "typescript",
          "vim",
          "xml",
          "yaml"
        }, 
        -- Install parsers synchronously (only applied to `ensure_installed`)
        highlight = {
          enable = true,
          -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end
        },
        indent = { enable = true }
      }
    )
  end
}

