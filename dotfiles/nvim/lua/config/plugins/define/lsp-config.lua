return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      local lsp_list = {
        "lua_ls"
      }

      require("mason-lspconfig").setup({
        ensure_installed = lsp_list
      })
      vim.lsp.config("*", {})
      vim.lsp.enable(lsp_list)
 
   end
  }
}

