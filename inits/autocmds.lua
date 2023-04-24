local api = vim.api
local fn = vim.fn
api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.tex",
	desc = "Update Compiled PDF",
	callback = function()
		local file_name = vim.fn.expand("%:p"):gsub(" ", "\\ ")
		local option = fn.input("Compile: ")
		if option:find("y") then
			api.nvim_command("!lualatex " .. file_name)
			api.nvim_command("!rm *.log")
			api.nvim_command("!rm *.aux")
			api.nvim_command("!rm *.out")
		end
	end,
})
