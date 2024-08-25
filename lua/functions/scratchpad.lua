
Scratchpad = {}

Scratchpad.setup = function()
  vim.api.nvim_create_user_command("Scratchpad", Scratchpad.create, {})
end

Scratchpad.create = function()
  vim.cmd(string.format("e /tmp/%s.txt", vim.cmd("!date")))
end

return Scratchpad

