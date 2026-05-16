return {
  -- Telescope (replaces fzf.vim)
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>p", function() require("telescope.builtin").find_files() end,  desc = "Find files" },
      { "<leader>b", function() require("telescope.builtin").buffers() end,     desc = "Buffers" },
      { "<leader>h", function() require("telescope.builtin").oldfiles() end,    desc = "Recent files" },
      { "<leader>g", function() require("telescope.builtin").live_grep() end,   desc = "Live grep" },
      { "<leader>f", function() require("telescope.builtin").grep_string() end, desc = "Grep word/selection" },
      { "<leader>f", function()
          local s = vim.fn.getreg('"')
          vim.cmd('normal! "vy')
          require("telescope.builtin").grep_string({ search = vim.fn.getreg("v") })
          vim.fn.setreg('"', s)
        end, mode = "v", desc = "Grep selection" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          path_display = { "truncate" },
          file_ignore_patterns = { "node_modules", "%.git/", "dist/", "build/" },
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
              ["<Esc>"] = "close",
            },
          },
        },
        pickers = {
          find_files = { hidden = true },
        },
        extensions = {
          fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true },
        },
      })
      pcall(telescope.load_extension, "fzf")
    end,
  },

  -- Git signs (replaces gitgutter)
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function nmap(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
        end
        nmap("]h", function() gs.nav_hunk("next") end, "Next hunk")
        nmap("[h", function() gs.nav_hunk("prev") end, "Prev hunk")
        nmap("<leader>hp", gs.preview_hunk,           "Preview hunk")
        nmap("<leader>hr", gs.reset_hunk,             "Reset hunk")
        nmap("<leader>hs", gs.stage_hunk,             "Stage hunk")
        nmap("<leader>hb", gs.toggle_current_line_blame, "Toggle blame")
      end,
    },
  },

  -- File explorer (replaces vinegar/netrw)
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Open parent dir (oil)" },
    },
    opts = {
      default_file_explorer = true,
      view_options = { show_hidden = true },
      keymaps = {
        ["q"] = "actions.close",
      },
    },
  },

  -- Comment (gcc, gc)
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local ap = require("nvim-autopairs")
      ap.setup({ check_ts = true })
      local cmp_ok, cmp = pcall(require, "cmp")
      if cmp_ok then
        cmp.event:on("confirm_done",
          require("nvim-autopairs.completion.cmp").on_confirm_done())
      end
    end,
  },

  -- Surround (cs"', ds", ysiw")
  {
    "kylechui/nvim-surround",
    event = { "BufReadPost", "BufNewFile" },
    version = "*",
    opts = {},
  },

  -- Rainbow brackets (replaces luochen1990/rainbow)
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },

  -- Color preview (replaces vim-css-color)
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      user_default_options = {
        css = true,
        tailwind = true,
        names = false,
      },
    },
  },

  -- Emmet (replaces emmet-vim)
  {
    "olrtg/nvim-emmet",
    event = "InsertEnter",
    config = function()
      vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation,
        { desc = "Emmet wrap" })
    end,
  },

  -- Flash motion (better than default search nav)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", function() require("flash").jump() end,        mode = { "n", "x", "o" }, desc = "Flash" },
      { "S", function() require("flash").treesitter() end,  mode = { "n", "x", "o" }, desc = "Flash treesitter" },
    },
  },

  -- TODO comments highlight + search
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>xt", "<cmd>TodoTelescope<CR>", desc = "Find TODOs" },
    },
  },
}
