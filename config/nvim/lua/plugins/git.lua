return {
  -- Fugitive-equivalent — minimal but covers status/blame/log
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Gedit", "GBrowse", "Gvdiffsplit" },
    keys = {
      { "<leader>gs", "<cmd>Git<CR>",       desc = "Git status" },
      { "<leader>gb", "<cmd>Git blame<CR>", desc = "Git blame" },
      { "<leader>gd", "<cmd>Gdiffsplit<CR>",desc = "Git diff split" },
    },
  },
}
