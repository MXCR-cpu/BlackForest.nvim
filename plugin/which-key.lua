local g = vim.g
local wk = require('which-key')
local ivy_picker = require("telescope.themes").get_ivy({})

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local create_ivy_picker = function(values, opts)
  print(vim.inspect(values))
  opts = opts or {}
  pickers.new(opts, require("telescope.themes").get_ivy({
    prompt_title = "Colors",
    finder = finders.new_table({
      results = values
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local config = require("lspconfig.configs")[selection[1]]
        config.launch()
      end)
      return true
    end
  })):find()
end

wk.setup {
  ignore_missing = true,
  icons = {
    separator = "->",
  }
}

wk.register({
  L = { [[<cmd>Lazy sync<CR>]], 'Lazy Sync' },
  V = { [[<cmd>StartupTime<CR>]], 'VimStartup Time' },
  -- f = { function() vim.lsp.buf.format{ async = true } end, 'Format' },
  q = { [[<cmd>q!<CR>]], 'Force Quit' },
  w = { [[<cmd>w!<CR>]], 'Force Write' },
  z = { [[<cmd>luafile $MYVIMRC<CR>]], 'Reload Neovim' },
  a = {
    name = 'Align',
    L = { function() require("utility").align("left" , true)  end, 'Align Gap Left'  },
    R = { function() require("utility").align("right", true)  end, 'Align Gap Right' },
    l = { function() require("utility").align("left" , false) end, 'Align Left'      },
    r = { function() require("utility").align("right", false) end, 'Align Right'     },
  },
  b = {
    name = 'Buffer',
    n = { [[<cmd>bnext<CR>]], 'Next' },
    p = { [[<cmd>bprevious<CR>]], 'Previous' },
    d = { [[<cmd>bnext | bd #<CR>]], 'Delete' },
  },
  c = {
    name = 'Codium',
    e = { [[<cmd>CodeiumEnable<CR>]], 'Enable Codeium' },
    d = { [[<cmd>CodeiumDisable<CR>]], 'Disable Codeium' },
  },
  d = {
    name = "Diagnostic",
    a = { function() vim.lsp.buf.code_action() end, 'Code Action' },
    c = { function() vim.lsp.buf.declaration() end, 'Declaration' },
    d = { [[<cmd>DMsg<CR>]], 'Print Diagnostics' },
    h = { function() vim.lsp.buf.hover() end, 'Hover' },
    i = { function() vim.lsp.buf.implementation() end, 'Implementation' },
    s = { function() vim.lsp.buf.signature_help() end, 'Signature Help' },
    t = { function() vim.lsp.buf.type_definition() end, 'Type Defintion' },
  },
  e = {
    name = 'Telescope',
    a = { function() require("telescope.builtin").autocommands(ivy_picker) end, 'Autocommands'     },
    b = { function() require("telescope.builtin").buffers(ivy_picker)      end, 'List Buffers'     },
    c = { function() require("telescope.builtin").highlights(ivy_picker)   end, 'Highlight Groups' },
    d = { function() require("telescope.builtin").diagnostics(ivy_picker)  end, 'List Diagnostics' },
    e = { function() require("telescope.builtin").live_grep(ivy_picker)    end, 'Live Grep'        },
    f = { function() require("telescope.builtin").find_files(ivy_picker)   end, 'Find Files'       },
    g = {
      name = 'Git',
      b = { function() require("telescope.builtin").git_branches(ivy_picker) end, 'Branches' },
      c = { function() require("telescope.builtin").git_commit(ivy_picker) end, 'Commit' },
      f = { function() require("telescope.builtin").git_files(ivy_picker) end, 'Files' },
      s = { function() require("telescope.builtin").git_status(ivy_picker) end, 'Status' },
      t = { function() require("telescope.builtin").git_stash(ivy_picker) end, 'Stash' },
    },
    h = { function() require("telescope.builtin").help_tags(ivy_picker) end, 'Help Tags' },
    j = { function() require("telescope.builtin").jumplist(ivy_picker) end, 'Jump List' },
    k = { function() require("telescope.builtin").marks(ivy_picker) end, 'Marks' },
    l = {
      name = 'LSP',
      d = { function() require("telescope.builtin").lsp_definitions(ivy_picker) end, 'Definitions' },
      i = { function() require("telescope.builtin").lsp_implementations(ivy_picker) end, 'Implementations' },
      r = { function() require("telescope.builtin").lsp_references(ivy_picker) end, 'References' },
      s = { function() require("telescope.builtin").lsp_document_symbols(ivy_picker) end, 'Symbols' },
      t = { function() require("telescope.builtin").lsp_type_definitions(ivy_picker) end, 'Type Definitions' },
    },
    m = { function() require("telescope.builtin").man_pages(ivy_picker) end, 'Man Pages' },
  },
  i = {
    name = 'Codeium',
    d = { [[<cmd>CodeiumDisable<CR>]], 'Disable Codeium' },
    e = { [[<cmd>CodeiumEnable<CR>]], 'Enable Codeium' },
    ['<C-g>'] = { '', 'Accept Completion' },
    ['<C-;>'] = { '', 'Cycle Forward' },
    ['<C-,>'] = { '', 'Cycle Backward' },
    ['<C-x>'] = { '', 'Clear Completion' },
  },
  l = {
    name = 'LSP',
    r = { [[<cmd>LspRestart<CR>]], 'Restart Lsp' },
    s = {
      function()
        local installed_servers = require("mason-lspconfig").get_installed_servers()
        create_ivy_picker(installed_servers, { prompt_title = "Servers" })
      end,
      'Start Lsp'
    },
    i = { [[<cmd>LspInfo<CR>]], 'Lsp Info' },
    l = { string.format([[<cmd>e %s/.local/state/nvim/lsp.log<CR>]], os.getenv('HOME')), 'Lsp Log' },
    p = { [[<cmd>LspStop<CR>]], 'Stop Lsp' },
    m = {
      name = 'Mason',
      l = { string.format([[<cmd>e %s/.local/state/nvim/mason.log<CR>]], os.getenv('HOME')), 'Mason Log' },
      m = { [[<cmd>Mason<CR>]], 'Mason' },
      u = { [[<cmd>MasonUpdate<CR>]], 'Mason Update' },
    }
  },
  n = { [[<cmd>Neotree toggle reveal right<CR>]], 'NeoTree Toggle' },
  f = { [[<cmd>Neotree focus<CR>]], 'NeoTree Toggle' },
  N = {
    name = 'Luasnip',
    E = { function() require("luasnip.loaders").edit_snippet_files() end, 'Edit Snippets' },
    O = { string.format([[e %s/Luasnip/]], vim.g.nvim_directory), 'Open Snippet Directory' },
  },
  o = {
    name = 'Open Config',
    a = { string.format([[<cmd>e %s/.config/alacritty/alacritty.toml<CR>]], os.getenv('HOME')), 'Alacritty' },
    c = {
      function()
        local opts = { cwd = os.getenv('HOME') .. "/.config/BlackForest/", prompt_title = 'BlackForest' }
        require('telescope.builtin').find_files(require('telescope.themes').get_ivy(opts))
      end,
      'BlackForest'
    },
    h = {
      function()
        local opts = { cwd = string.format([[%s/.scripts/chez/]], os.getenv('HOME')), prompt_title = 'Cherish Files' }
        require('telescope.builtin').find_files(require('telescope.themes').get_ivy(opts))
      end,
      'Cherish Files'
    },
    s = {
      function()
        local opts = { cwd = '/Users/iMac/.scripts/', prompt_title = 'Script', hidden = true }
        require('telescope.builtin').find_files(require('telescope.themes').get_ivy(opts))
      end,
      'Scripts'
    },
    t = {
      string.format([[<cmd>e %s/.tmux.conf<CR>]], os.getenv('HOME')),
      'Tmux'
    },
    z = {
      function()
        local opts = { cwd = '/Users/iMac/.config/zsh/', prompt_title = 'Zsh Dot Files', hidden = true }
        require('telescope.builtin').find_files(require('telescope.themes').get_ivy(opts))
      end,
      'Zsh'
    },
  },
  s = {
    name = 'Surround',
    a = { [[<cmd>SurroundAdd<CR>]], 'Add' },
    d = { [[<cmd>SurroundDelete<CR>]], 'Delete' },
  },
  u = {
    name = "UndoTree",
    t = { [[<cmd>UndotreeToggle<CR>]], 'Undotree Toggle' },
    f = { [[<cmd>UndotreeFocus<CR>]], 'Undotree Toggle' },
  },
  Z = {
    name = 'Boop',
    c = {
       name = 'Case',
      c = { [[<cmd>BoopCamelCase<CR>]], 'Camel' },
      k = { [[<cmd>BoopKebabCase<CR>]], 'Kebab' },
      s = { [[<cmd>BoopSnakeCase<CR>]], 'Snake' },
    },
    f = {
      name = 'From',
      b = { [[<cmd>BoopToBinary<CR>]], 'Binary' },
      e = { [[<cmd>BoopToBase64<CR>]], 'Base64' },
      h = { [[<cmd>BoopToHex<CR>]], 'Hex' },
      o = { [[<cmd>BoopToOctal<CR>]], 'Octal' },
    },
    t = {
      name = 'To',
      b = { [[<cmd>BoopToBinary<CR>]], 'Binary' },
      e = { [[<cmd>BoopToBase64<CR>]], 'Base64' },
      h = { [[<cmd>BoopToHex<CR>]], 'Hex' },
      o = { [[<cmd>BoopToOctal<CR>]], 'Octal' },
      s = { [[<cmd>BoopToSHA256<CR>]], 'SHA256' },
    },
    z = { [[<cmd>Boop<CR>]], 'Open' },
  }
}, { prefix = '<leader>' })

