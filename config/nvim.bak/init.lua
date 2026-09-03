vim.notify = (function(orig)
	return function(msg, level, opts)
		if type(msg) == "string" and msg:match("The `require%('lspconfig'%)` \"framework\" is deprecated") then
			return
		end
		return orig(msg, level, opts)
	end
end)(vim.notify)
vim.opt.termguicolors = true
vim.o.clipboard = "unnamedplus"
require("mappings")
require("config.lazy")
require("options")
require("hardtime").setup()
