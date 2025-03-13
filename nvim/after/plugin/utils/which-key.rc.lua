local which_key = require("which-key")
local is_open = require("utils").is_open

which_key.setup()
which_key.add({
  { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },

  { "<leader>d", group = "Debug" },
  { "<leader>dc", "<cmd>lua require 'dap'.continue()<cr>", desc = "Continue" },
  { "<leader>dd", "<cmd>lua require 'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
  { "<leader>di", "<cmd>lua require 'dap'.step_into()<cr>", desc = "Step Into" },
  { "<leader>do", "<cmd>lua require 'dap'.step_over()<cr>", desc = "Step Over" },
  { "<leader>dr", "<cmd>lua require 'dap'.repl.open()<cr>", desc = "REPL" },

  { "<leader>f", group = "Fuzzy" },
  { "<leader>fa", "<cmd>FzfLua awesome_colorschemes<cr>", desc = "Colorschemes+" },
  { "<leader>fb", "<cmd>FzfLua builtin<cr>", desc = "Builtins" },
  { "<leader>fc", "<cmd>FzfLua colorschemes<cr>", desc = "Colorschemes" },
  { "<leader>fd", "<cmd>FzfLua changes<cr>", desc = "Changes" },
  { "<leader>fh", "<cmd>FzfLua highlights<cr>", desc = "Highlight Groups" },
  { "<leader>fj", "<cmd>FzfLua jumps<cr>", desc = "Jumps" },
  { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
  { "<leader>fm", "<cmd>FzfLua marks<cr>", desc = "Marks" },
  { "<leader>fp", "<cmd>FzfLua profiles<cr>", desc = "Profiles" },
  { "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "Resume" },
  { "<leader>ft", "<cmd>FzfLua tags<cr>", desc = "Tags" },
  { "<leader>fx", "<cmd>FzfLua commands<cr>", desc = "Commands" },

  { "<leader>g", group = "Git" },
  { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Lazygit" },
  { "<leader>gd", "<cmd>lua require 'gitsigns'.diffthis('~')<cr>", desc = "Diff" },
  { "<leader>gh", "<cmd>Telescope git_bcommits<cr>", desc = "File History" },
  { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk" },
  { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk" },
  { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame" },
  { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk" },
  { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk" },
  { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer" },
  { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk" },
  { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },

  { "<leader>l", group = "LSP" },
  { "<leader>la", "<cmd>Lspsaga code_action<cr>", desc = "Code Actions" },
  { "<leader>lc", "<cmd>SupermavenToggle<cr>", desc = "Toggle Completions" },
  { "<leader>ld", "<cmd>Telescope lsp_document_diagnostics<cr>", desc = "Document Diagnostics" },
  { "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", desc = "Format" },
  { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
  { "<leader>lI", "<cmd>LspInstallInfo<cr>", desc = "Installer Info" },
  { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
  { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
  { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
  { "<leader>lw", "<cmd>Telescope lsp_workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },

  { "<leader>m", group = "Mason" },
  { "<leader>ml", "<cmd>MasonLog<cr>", desc = "Log" },
  { "<leader>mm", "<cmd>Mason<cr>", desc = "GUI" },
  { "<leader>mu", "<cmd>MasonUpdate<cr>", desc = "Update" },

  { "<leader>p", group = "Plugins" },
  { "<leader>pc", "<cmd>Lazy clean<cr>", desc = "Clean" },
  { "<leader>ph", "<cmd>Lazy health<cr>", desc = "Health Check" },
  { "<leader>pi", "<cmd>Lazy install<cr>", desc = "Install" },
  { "<leader>pp", "<cmd>Lazy<cr>", desc = "GUI" },
  { "<leader>pr", "<cmd>Lazy restore<cr>", desc = "Restore" },
  { "<leader>ps", "<cmd>Lazy sync<cr>", desc = "Sync" },
  { "<leader>pu", "<cmd>Lazy update<cr>", desc = "Update" },

  { "<leader>s", group = "Search" },
  { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
  { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers" },
  { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout Branch" },
  { "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
  { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
  { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
  { "<leader>sm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
  { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },

  { "<leader>t", group = "Treesitter" },
  { "<leader>tu", "<cmd>TSUpdate<cr>", desc = "Update" },

  { "<leader>u", group = "Utilities" },
  { "<leader>um", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown" },
  {
    "<leader>ur",
    function()
      local api = require("nvim-tree.api")
      local node = api.tree.get_node_under_cursor()
      if node and node.absolute_path then
        vim.cmd("term " .. node.absolute_path)
      else
        print("No file selected")
      end
    end,
    desc = "Run Shell Script",
  },
  { "<leader>ux", "<cmd>!chmod +x %<cr>", desc = "Make Executable" },

  { "<leader>x", group = "Terminal" },
  { "<leader>xf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float" },
  { "<leader>xh", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal" },
  { "<leader>xv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical" },
  {
    "<leader>xx",
    function()
      vim.cmd("ToggleTerm direction=horizontal")

      if is_open("NvimTree") then
        vim.cmd("NvimTreeClose")
        vim.cmd("NvimTreeOpen")
      end

      vim.cmd("wincmd l")
      vim.cmd("wincmd j")
      vim.cmd("sleep 200m")
      vim.cmd("startinsert")
    end,
    desc = "Toggle",
  },

  { "<leader>z", group = "Misc" },
  { "<leader>zm", "<cmd>messages<cr>", desc = "Messages" },
})
