local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "petertriho/cmp-git",
    {
      "saadparwaiz1/cmp_luasnip",
      dependencies = {
        {
          "L3MON4D3/LuaSnip",
          build = "make install_jsregexp",
        },
      },
    },
    "onsails/lspkind.nvim",
  },
}

function M.config()
  local cmp = require("cmp")
  local lspkind = require("lspkind")

  cmp.setup({
    completion = {
      completeopt = "menu,menuone,noinsert,noselect",
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text",
        menu = {
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          vsnip = "[VSnippet]",
        },
      }),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-f>"] = cmp.mapping.scroll_docs(-4),
      ["<C-b>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<Tab>"] = cmp.mapping.confirm({ select = true }),
    }),
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    -- Default snippet sources
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
    }, {
      { name = "buffer" },
    }),
  })
end

return M
