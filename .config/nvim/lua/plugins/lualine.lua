require('lualine').setup {
  options = {
    theme  = "dracula-nvim",
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_c = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    }
  }
}
