local M = {
  "hrsh7th/nvim-cmp",
  event = "VeryLazy",
  dependencies = {
    "dmitmel/cmp-cmdline-history",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "neovim/nvim-lspconfig",
    "octaltree/cmp-look",
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
    "windwp/nvim-autopairs",
  },
}

function M.config()
  local cmp = require("cmp")
  local lspkind = require("lspkind")

  -- Default completion logic
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
          path = "[Path]",
          look = "[Look]",
          luasnip = "[LuaSnip]",
          git = "[Git]",
          cmd = "[Cmd]",
          cmd_history = "[CmdHistory]",
          nvim_lua = "[NvimLua]",
        },
      }),
    },
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
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
    sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "luasnip" },
      { name = "path" },
      { name = "git" },
      { name = "nvim_lua" },
      {
        name = "look",
        max_item_count = 10,
        keyword_length = 3,
        option = { convert_case = true, loud = true },
      },
      { name = "buffer" },
    },
  })

  -- CMD specific comletion
  cmp.setup.cmdline(":", {
    performance = {
      max_view_entries = 15,
    },
    sources = {
      { name = "path" },
      { name = "cmdline" },
      { name = "cmdline_history" },
      { name = "buffer" },
    },
  })
  cmp.setup.cmdline("/", {
    performance = {
      max_view_entries = 15,
    },
    sources = {
      { name = "buffer" },
      { name = "cmdline_history" },
      { name = "nvim_lsp_document_symbol" },
    },
  })
  -- Git specific completion
  cmp.setup.filetype("gitcommit", {
    sources = {
      { name = "git" },
      { name = "buffer" },
    },
  })

  -- Add autopairs support
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
