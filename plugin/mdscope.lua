if vim.g.loaded_mdscope then
  return
end
vim.g.loaded_mdscope = true

-- Call the setup function
require('mdscope').setup()

