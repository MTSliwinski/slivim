return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  config = function()
    require("project_nvim").setup({
      manual_mode = false,
      detection_methods = { "pattern" },
      patterns = { ".git", "Makefile", "package.json" },
    })
    -- integrate with telescope (loaded lazily by telescope.nvim spec)
    local ok, telescope = pcall(require, "telescope")
    if ok then
      telescope.load_extension("projects")
    end
  end,
}
