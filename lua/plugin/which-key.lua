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


---@param aspect string
---@param opts table
local function telescope_builtin(aspect, opts)
  return function()
    require("telescope.builtin")[aspect](opts)
  end
end

---@param aspect string
local function neogit_open(aspect)
  return function()
    require("neogit").open({ aspect })
  end
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
  -- { "<leader>N", group = "Luasnip" },
  -- { "<leader>NE", require("luasnip.loaders").edit_snippet_files, desc = "Edit Snippets" },
  -- { "<leader>NO", "<cmd>e /Users/iMac/.config/BlackForest/Luasnip/<CR>", desc = "Open Snippet Directory" },
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
  { "<leader>da", vim.lsp.buf.code_action, desc = "Code Action" },
  { "<leader>dc", vim.lsp.buf.declaration, desc = "Declaration" },
  { "<leader>dh", vim.lsp.buf.hover, desc = "Hover" },
  { "<leader>di", vim.lsp.buf.implementation, desc = "Implementation" },
  { "<leader>ds", vim.lsp.buf.signature_help, desc = "Signature Help" },
  { "<leader>dt", vim.lsp.buf.type_definition, desc = "Type Defintion" },
  { "<leader>e", group = "Telescope" },
  { "<leader>ea", telescope_builtin("autocommands", {}), desc = "Autocommands" },
  { "<leader>bl", telescope_builtin("buffers", {}), desc = "List Buffers" },
  { "<leader>ec", require("telescope.builtin").highlights, desc = "Highlight Groups" },
  {
    "<leader>dd",
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
  { "<leader>r", require("telescope.builtin").live_grep, desc = "Live Grep" },
  { "<leader>f", require("telescope.builtin").fd, desc = "Find Files" },
  { "<leader>G", "<cmd>FloatermNew --height=0.8 --width=0.8 --wintype=float --name=git --position=center --autoclose=2 lazygit<CR>", desc="Lazy Git" },
  { "<leader>g", group = "Git" },
  { "<leader>gn", "<cmd>Neogit<CR>", desc = "Neogit" },
  { "<leader>gb", neogit_open("branch"), desc = "Branches" },
  { "<leader>gc", neogit_open("commit"), desc = "Commit" },
  { "<leader>gd", neogit_open("diff"), desc = "Diff" },
  { "<leader>gf", neogit_open("fetch"), desc = "Fetch" },
  { "<leader>gl", neogit_open("log"), desc = "Log" },
  { "<leader>gr", neogit_open("cherry_pick"), desc = "Cherry Pick" },
  { "<leader>gt", neogit_open("stash"), desc = "Stash" },
  { "<leader>ge", neogit_open("bisect"), desc = "Bisect" },
  { "<leader>gw", neogit_open("worktree"), desc = "Worktree" },
  { "<leader>gs", telescope_builtin("git_status", {}), desc = "Status" },
  { "<leader>eh", telescope_builtin("help_tags", {}), desc = "Help Tags" },
  { "<leader>ej", telescope_builtin("jumplist", {}), desc = "Jump List" },
  { "<leader>ek", telescope_builtin("marks", {}), desc = "Marks" },
  { "<leader>el", group = "LSP" },
  { "<leader>em", telescope_builtin("man_pages", {}), desc = "Man Pages" },
  -- { "<leader>f", "<cmd>Neotree focus<CR>", desc = "NeoTree Toggle" },
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
  { "<leader>ld", telescope_builtin("lsp_definitions", {}), desc = "Definitions" },
  { "<leader>li", telescope_builtin("lsp_implementations", {}), desc = "Implementations" },
  { "<leader>lf", telescope_builtin("lsp_references", {}), desc = "References" },
  { "<leader>ly", telescope_builtin("lsp_document_symbols", {}), desc = "Symbols" },
  { "<leader>lt", telescope_builtin("lsp_type_definitions", {}), desc = "Type Definitions" },
  { "<leader>n", "<cmd>Neotree toggle reveal right<CR>", desc = "NeoTree Toggle" },
  { "<leader>o", group = "Open" },
  { "<leader>oa", "<cmd>e /Users/iMac/.config/alacritty/alacritty.toml<CR>", desc = "Alacritty" },
  {
      "<leader>oc",
      telescope_builtin("find_files", ivy_picker({
        cwd = vim.fs.joinpath(vim.env.HOME, ".config", "BlackForest"),
        prompt_title = "BlackForest",
      })),
      desc = "BlackForest",
  },
  {
    "<leader>of",
    telescope_builtin("themes", ivy_picker({
        cwd = vim.fs.joinpath(vim.env.HOME, ".config", "fish"),
        prompt_title = "Fish Files",
        hidden = true,
      })),
    desc = "Fish",
  },
  {
    "<leader>os",
    telescope_builtin("themes", ivy_picker({
        cwd = vim.fs.joinpath(vim.env.HOME, ".config", "fish"),
        prompt_title = "Fish Files",
        hidden = true,
      })),
    desc = "Scripts",
  },
  { "<leader>ot", "<cmd>e /Users/iMac/.tmux.conf<CR>", desc = "Tmux" },
  {
    "<leader>oz",
    telescope_builtin("find_files", ivy_picker({
        cwd = vim.env.HOME .. "/.config/zsh/",
        prompt_title = "Zsh Files",
        hidden = true
      })),
    desc = "Zsh",
  },
  { "<leader>q", group = "Force Quit?" },
  { "<leader>qy", "<cmd>q!<CR>", desc = "yes" },
  { "<leader>s", group = "Surround" },
  { "<leader>sa", "<cmd>SurroundAdd<CR>", desc = "Add" },
  { "<leader>sd", "<cmd>SurroundDelete<CR>", desc = "Delete" },
  { "<leader>u", "<cmd>UndotreeToggle<CR>", desc="Undotree" },
  { "<leader>w", "<cmd>w!<CR>", desc = "Force Write" },
  { "<leader>z", "<cmd>Zoxide<CR>", desc = "Zoxide" },
})
