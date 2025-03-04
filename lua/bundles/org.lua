local org_roam_directory = "/Users/iMac/Documents/org/roam"

require("orgmode").setup({
  org_agenda_files = { "/Users/iMac/Documents/org/agenda" },
  org_default_notes_file = org_roam_directory,
  mappings = {
    disable_all = true
  }
})

require("telescope").load_extension("orgmode")

require("org-roam").setup({
  directory = org_roam_directory,
  org_files = {},
  bindings = false,
})



