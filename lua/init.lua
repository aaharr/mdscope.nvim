local M = {}

-- A simple function that prints a message
function M.say_hello()
  print(M.options.message)
end

-- A function to set up the plugin
function M.setup(opts)
  opts = opts or {}
  -- Set up default options
  M.options = vim.tbl_deep_extend("force", {
    message = "Hello from myplugin!",
  }, opts)

  -- Define commands in Lua
  vim.api.nvim_create_user_command('MyPluginHello', function()
    M.say_hello()
  end, {})
end

return M

