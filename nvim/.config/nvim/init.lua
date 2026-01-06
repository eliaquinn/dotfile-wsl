require("eliaquinn.core")
require("eliaquinn.lazy")

vim.api.nvim_create_autocmd("RecordingEnter", {
	callback = function()
		local register = vim.fn.reg_recording()
		vim.notify("Starting record macro register" .. register, vim.log.levels.INFO)
	end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
	callback = function()
		local register = vim.fn.reg_recording()
		vim.notify("Starging record macro register" .. register, " done", vim.log.levels.INFO)
	end,
})
