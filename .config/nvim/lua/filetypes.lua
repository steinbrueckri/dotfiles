vim.filetype.add({
  pattern = {
    -- Jinja2
    [".*%.html%.j2"] = "jinja",
    -- Django-Templates
    ["*/templates/.*%.html"] = "htmldjango",
  },
})
