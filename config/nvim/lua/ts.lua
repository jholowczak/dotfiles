-- telescope configuration
require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    },
    ["projects"] = {},
    ["possession"] = {}
  }
}
