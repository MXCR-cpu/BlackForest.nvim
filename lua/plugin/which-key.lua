local wk = require("which-key")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local ivy_picker = require("telescope.themes").get_ivy

local function lsp_server_picker()
  pickers.new(
    {},
    ivy_picker({
      prompt_title = "Servers",
      finder = finders.new_table({
        results = require("mason-lspconfig").get_installed_servers(),
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        local function_handle = function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          require("lspconfig.configs")[selection[1]].launch()
        end
        map("n", "<cr>", function_handle)
        map("i", "<cr>", function_handle)
        return true
      end,
    })
  ):find()
end

wk.setup({
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
    ellipsis = "…",
    -- set to false to disable all mapping icons,
    -- both those explicitely added in a mapping
    -- and those from rules
    mappings = true,
    --- See `lua/which-key/icons.lua` for more details
    --- Set to `false` to disable keymap icons from rules
    rules = {},
    -- use the highlights from mini.icons
    -- When `false`, it will use `WhichKeyIcon` instead
    colors = true,
    -- used by key format
    keys = {
      Up = " ",
      Down = " ",
      Left = " ",
      Right = " ",
      C = "󰘴 ",
      M = "󰘵 ",
      D = "󰘳 ",
      S = "󰘶 ",
      CR = "󰌑 ",
      Esc = "󱊷 ",
      ScrollWheelDown = "󱕐 ",
      ScrollWheelUp = "󱕑 ",
      NL = "󰌑 ",
      BS = "󰁮",
      Space = "󱁐 ",
      Tab = "󰌒 ",
      F1 = "󱊫",
      F2 = "󱊬",
      F3 = "󱊭",
      F4 = "󱊮",
      F5 = "󱊯",
      F6 = "󱊰",
      F7 = "󱊱",
      F8 = "󱊲",
      F9 = "󱊳",
      F10 = "󱊴",
      F11 = "󱊵",
      F12 = "󱊶",
    },
  },
})

wk.add({
  -- { "<leader>L", "<cmd>Lazy sync<CR>", desc = "Lazy Sync" },
  { "<leader>N", group = "Luasnip" },
  {
    "<leader>NE",
    function()
      require("luasnip.loaders").edit_snippet_files()
    end,
    desc = "Edit Snippets",
  },
  { "<leader>NO", "<cmd>e /Users/iMac/.config/BlackForest/Luasnip/<CR>", desc = "Open Snippet Directory" },
  -- { "<leader>V", "<cmd>StartupTime<CR>", desc = "VimStartup Time" },
  { "<leader>Z", group = "Boop" },
  { "<leader>Zc", group = "Case" },
  { "<leader>Zcc", "<cmd>BoopCamelCase<CR>", desc = "Camel" },
  { "<leader>Zck", "<cmd>BoopKebabCase<CR>", desc = "Kebab" },
  { "<leader>Zcs", "<cmd>BoopSnakeCase<CR>", desc = "Snake" },
  { "<leader>Zf", group = "From" },
  { "<leader>Zfb", "<cmd>BoopToBinary<CR>", desc = "Binary" },
  { "<leader>Zfe", "<cmd>BoopToBase64<CR>", desc = "Base64" },
  { "<leader>Zfh", "<cmd>BoopToHex<CR>", desc = "Hex" },
  { "<leader>Zfo", "<cmd>BoopToOctal<CR>", desc = "Octal" },
  { "<leader>Zt", group = "To" },
  { "<leader>Ztb", "<cmd>BoopToBinary<CR>", desc = "Binary" },
  { "<leader>Zte", "<cmd>BoopToBase64<CR>", desc = "Base64" },
  { "<leader>Zth", "<cmd>BoopToHex<CR>", desc = "Hex" },
  { "<leader>Zto", "<cmd>BoopToOctal<CR>", desc = "Octal" },
  { "<leader>Zts", "<cmd>BoopToSHA256<CR>", desc = "SHA256" },
  { "<leader>Zz", "<cmd>Boop<CR>", desc = "Open" },
  { "<leader>a", group = "Align" },
  {
    "<leader>aL",
    function()
      require("utility").align("left", true)
    end,
    desc = "Align Gap Left",
  },
  {
    "<leader>aR",
    function()
      require("utility").align("right", true)
    end,
    desc = "Align Gap Right",
  },
  {
    "<leader>al",
    function()
      require("utility").align("left", false)
    end,
    desc = "Align Left",
  },
  {
    "<leader>ar",
    function()
      require("utility").align("right", false)
    end,
    desc = "Align Right",
  },
  { "<leader>b", group = "Buffer" },
  { "<leader>bd", "<cmd>bnext | bd #<CR>", desc = "Delete" },
  { "<leader>bn", "<cmd>bnext<CR>", desc = "Next" },
  { "<leader>bp", "<cmd>bprevious<CR>", desc = "Previous" },
  { "<leader>c", group = "Codium" },
  { "<leader>cd", "<cmd>CodeiumDisable<CR>", desc = "Disable Codeium" },
  { "<leader>ce", "<cmd>CodeiumEnable<CR>", desc = "Enable Codeium" },
  { "<leader>d", group = "Diagnostic" },
  { "<leader>dd", "<cmd>DMsg<CR>", desc = "Print Diagnostics" },
  {
    "<leader>da",
    function()
      vim.lsp.buf.code_action()
    end,
    desc = "Code Action",
  },
  {
    "<leader>dc",
    function()
      vim.lsp.buf.declaration()
    end,
    desc = "Declaration",
  },
  {
    "<leader>dh",
    function()
      vim.lsp.buf.hover()
    end,
    desc = "Hover",
  },
  {
    "<leader>di",
    function()
      vim.lsp.buf.implementation()
    end,
    desc = "Implementation",
  },
  {
    "<leader>ds",
    function()
      vim.lsp.buf.signature_help()
    end,
    desc = "Signature Help",
  },
  {
    "<leader>dt",
    function()
      vim.lsp.buf.type_definition()
    end,
    desc = "Type Defintion",
  },
  { "<leader>e", group = "Telescope" },
  {
    "<leader>ea",
    function()
      require("telescope.builtin").autocommands(ivy_picker())
    end,
    desc = "Autocommands",
  },
  {
    "<leader>eb",
    function()
      require("telescope.builtin").buffers(ivy_picker())
    end,
    desc = "List Buffers",
  },
  {
    "<leader>ec",
    function()
      require("telescope.builtin").highlights(ivy_picker())
    end,
    desc = "Highlight Groups",
  },
  {
    "<leader>ed",
    function()
      require("telescope.builtin").diagnostics(ivy_picker({
        bufnr = 0,
        sort_by = "severity",
        attach_mappings = function(prompt_bufnr, map)
          local function_handle = function(_)
            local state = action_state.get_selected_entry()
            local diagnostic_line = string.format("%s", state.text)
            actions.close(prompt_bufnr)
            vim.notify(diagnostic_line)
          end
          map("n", "<cr>", function_handle)
          return true
        end,
      }))
    end,
    desc = "List Diagnostics",
  },
  {
    "<leader>ee",
    function()
      require("telescope.builtin").live_grep(ivy_picker())
    end,
    desc = "Live Grep",
  },
  {
    "<leader>ef",
    function()
      require("telescope.builtin").fd(ivy_picker())
    end,
    desc = "Find Files",
  },
  { "<leader>eg", group = "Git" },
  {
    "<leader>egb",
    function()
      require("telescope.builtin").git_branches(ivy_picker())
    end,
    desc = "Branches",
  },
  {
    "<leader>egc",
    function()
      require("telescope.builtin").git_commit(ivy_picker())
    end,
    desc = "Commit",
  },
  {
    "<leader>egf",
    function()
      require("telescope.builtin").git_files(ivy_picker())
    end,
    desc = "Files",
  },
  {
    "<leader>egs",
    function()
      require("telescope.builtin").git_status(ivy_picker())
    end,
    desc = "Status",
  },
  {
    "<leader>egt",
    function()
      require("telescope.builtin").git_stash(ivy_picker())
    end,
    desc = "Stash",
  },
  {
    "<leader>eh",
    function()
      require("telescope.builtin").help_tags(ivy_picker())
    end,
    desc = "Help Tags",
  },
  {
    "<leader>ej",
    function()
      require("telescope.builtin").jumplist(ivy_picker())
    end,
    desc = "Jump List",
  },
  {
    "<leader>ek",
    function()
      require("telescope.builtin").marks(ivy_picker())
    end,
    desc = "Marks",
  },
  { "<leader>el", group = "LSP" },
  {
    "<leader>eld",
    function()
      require("telescope.builtin").lsp_definitions(ivy_picker())
    end,
    desc = "Definitions",
  },
  {
    "<leader>eli",
    function()
      require("telescope.builtin").lsp_implementations(ivy_picker())
    end,
    desc = "Implementations",
  },
  {
    "<leader>elr",
    function()
      require("telescope.builtin").lsp_references(ivy_picker())
    end,
    desc = "References",
  },
  {
    "<leader>els",
    function()
      require("telescope.builtin").lsp_document_symbols(ivy_picker())
    end,
    desc = "Symbols",
  },
  {
    "<leader>elt",
    function()
      require("telescope.builtin").lsp_type_definitions(ivy_picker())
    end,
    desc = "Type Definitions",
  },
  {
    "<leader>em",
    function()
      require("telescope.builtin").man_pages()
    end,
    desc = "Man Pages",
  },
  { "<leader>f", "<cmd>Neotree focus<CR>", desc = "NeoTree Toggle" },
  -- { "<leader>i", group = "Codeium" },
  -- { "<leader>i<C-,>", "", desc = "Cycle Backward" },
  -- { "<leader>i<C-;>", "", desc = "Cycle Forward" },
  -- { "<leader>i<C-g>", "", desc = "Accept Completion" },
  -- { "<leader>i<C-x>", "", desc = "Clear Completion" },
  -- { "<leader>id", "<cmd>CodeiumDisable<CR>", desc = "Disable Codeium" },
  -- { "<leader>ie", "<cmd>CodeiumEnable<CR>", desc = "Enable Codeium" },
  { "<leader>gc", group = "Comment" },
  { "<leader>l", group = "LSP" },
  { "<leader>li", "<cmd>LspInfo<CR>", desc = "Lsp Info" },
  { "<leader>ll", "<cmd>e /Users/iMac/.local/state/nvim/lsp.log<CR>", desc = "Lsp Log" },
  { "<leader>lm", group = "Mason" },
  { "<leader>lml", "<cmd>e /Users/iMac/.local/state/nvim/mason.log<CR>", desc = "Mason Log" },
  { "<leader>lmm", "<cmd>Mason<CR>", desc = "Mason" },
  { "<leader>lmu", "<cmd>MasonUpdate<CR>", desc = "Mason Update" },
  { "<leader>lp", "<cmd>LspStop<CR>", desc = "Stop Lsp" },
  { "<leader>lr", "<cmd>LspRestart<CR>", desc = "Restart Lsp" },
  { "<leader>ls", lsp_server_picker, desc = "Start Lsp" },
  { "<leader>n", "<cmd>Neotree toggle reveal right<CR>", desc = "NeoTree Toggle" },
  { "<leader>o", group = "Open" },
  { "<leader>oa", "<cmd>e /Users/iMac/.config/alacritty/alacritty.toml<CR>", desc = "Alacritty" },
  {
    "<leader>oc",
    function()
      local opts = {
        cwd = vim.fs.joinpath(vim.env.HOME, ".config", "BlackForest"),
        prompt_title = "BlackForest",
      }
      require("telescope.builtin").find_files(ivy_picker(opts))
    end,
    desc = "BlackForest",
  },
  {
    "<leader>of",
    function()
      local opts = {
        cwd = vim.fs.joinpath(vim.env.HOME, ".config", "fish"),
        prompt_title = "Fish Files",
        hidden = true,
      }
      require("telescope.builtin").find_files(require("telescope.themes").get_ivy(opts))
    end,
    desc = "Fish",
  },
  {
    "<leader>os",
    function()
      local opts = {
        cwd = vim.fs.joinpath(vim.env.HOME, ".scripts"),
        prompt_title = "Scripts",
        hidden = true,
      }
      require("telescope.builtin").find_files(require("telescope.themes").get_ivy(opts))
    end,
    desc = "Scripts",
  },
  { "<leader>ot", "<cmd>e /Users/iMac/.tmux.conf<CR>", desc = "Tmux" },
  {
    "<leader>oz",
    function()
      local opts = {
        cwd = vim.env.HOME .. "/.config/zsh/",
        prompt_title = "Zsh Files",
        hidden = true
      }
      require("telescope.builtin").find_files(ivy_picker(opts))
    end,
    desc = "Zsh",
  },
  { "<leader>q", group = "Force Quit?" },
  { "<leader>qy", "<cmd>q!<CR>", desc = "yes" },
  { "<leader>s", group = "Surround" },
  { "<leader>sa", "<cmd>SurroundAdd<CR>", desc = "Add" },
  { "<leader>sd", "<cmd>SurroundDelete<CR>", desc = "Delete" },
  { "<leader>u", group = "UndoTree" },
  { "<leader>uf", "<cmd>UndotreeFocus<CR>", desc = "Undotree Focus" },
  { "<leader>ut", "<cmd>UndotreeToggle<CR>", desc = "Undotree Toggle" },
  { "<leader>w", "<cmd>w!<CR>", desc = "Force Write" },
  { "<leader>z", "<cmd>Zoxide<CR>", desc = "Zoxide" },
})
