return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "zbirenbaum/copilot.lua",
    "zbirenbaum/copilot-cmp", -- Bridge between Copilot and nvim-cmp
  },
  config = function()
    local cmp = require("cmp")
    require("copilot_cmp").setup()
    local lspkind = require("lspkind")

    cmp.setup({
      sources = cmp.config.sources({
        { name = "copilot", group_index = 2 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "buffer", group_index = 2 },
        { name = "path", group_index = 2 },
      }),
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept first suggestion
        ["<C-f>"] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item() -- Cycle through LSP suggestions
          else
            fallback() -- Use Copilot fallback
          end
        end,
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol",
          max_width = 50,
          symbol_map = { Copilot = "" },
        }),
      },
    })
  end,
}
