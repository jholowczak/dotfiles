-- telescope configuration
local telescope = require('telescope')
telescope.setup {
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

telescope.load_extension('ui-select')
