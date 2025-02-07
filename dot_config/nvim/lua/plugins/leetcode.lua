return {
	"kawre/leetcode.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		-- "ibhagwan/fzf-lua",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		lang = "python3",
		-- lang = "rust",
		cn = { -- leetcode.cn
			enabled = true, ---@type boolean
			translator = true, ---@type boolean
			translate_problems = true, ---@type boolean
		},
		image_support = true,
		---@type lc.storage
		storage = {
			home = vim.fn.expand("~/workspace/leetcode"), -- 设置代码存储目录
			cache = vim.fn.stdpath("cache") .. "/leetcode", -- 设置缓存目录
		},
		-- 可选：自定义文件命名格式
		file_name_format = "${id}-${snake_case_title}.${ext}",
	},
	config = function(_, opts)
		-- 语言映射表
		local lang_map = {
			python3 = "python",
			python = "python",
			-- 可以在这里添加其他语言的映射
			-- rust = "rust",
			-- cpp = "cpp",
		}

		-- 获取映射后的语言目录名
		local lang = opts.lang or "python3"
		local dir_name = lang_map[lang] or lang

		-- 设置存储路径
		opts.storage = {
			home = vim.fn.expand("~/workspace/leetcode/" .. dir_name),
			cache = vim.fn.stdpath("cache") .. "/leetcode",
		}
		opts.file_name_format = "${id}-${snake_case_title}.${ext}"

		require("leetcode").setup(opts)
	end,
}
