local M = {}

local function is_ignored(ignored_buftypes, buf_nr)
	for _, buftype in ipairs(ignored_buftypes) do
		if vim.bo[buf_nr].buftype == buftype then
			return true
		end
	end

	return false
end

M.options = {
	show_index = true,
	fnamemodify = ":t",
	modified_string = " +",
	max_windows = 3,
	auto_hide = true,
	separator = "▕",
	window_separator = " | ",
	padding = "   ",
	ignored_buftypes = { "nofile" },
}

local function tabline(options)
	local s = ""

	for tab_nr = 1, vim.fn.tabpagenr("$") do
		if tab_nr == vim.fn.tabpagenr() then
			s = s .. "%#TabLineSel#"
		else
			s = s .. "%#TabLine#"
		end

		s = s .. options.padding

		if options.show_index then
			s = s .. "%" .. tab_nr .. "T"
			s = s .. tab_nr .. ". "
		end

		local tabname = ""

		local valid_buffers = {}

		for _, buf_nr in ipairs(vim.fn.tabpagebuflist(tab_nr)) do
			if not is_ignored(options.ignored_buftypes, buf_nr) then
				table.insert(valid_buffers, buf_nr)
			end
		end

		for idx, buf_nr in ipairs(valid_buffers) do
			local buffername = vim.api.nvim_buf_get_name(buf_nr)
			local buftype = vim.bo[buf_nr].buftype

			if idx > options.max_windows then
				break
			end

			if buftype == "help" then
				buffername = vim.fn.fnamemodify(buffername, options.fnamemodify .. ":s/.txt$/ /") .. "[H]"
			elseif buftype == "quickfix" then
				buffername = buffername .. "[Q]"
			elseif buffername == "" then
				buffername = "[No Name]"
			else
				buffername = vim.fn.fnamemodify(buffername, options.fnamemodify)
			end

			if vim.bo[buf_nr].modified then
				buffername = buffername .. options.modified_string
			end

			if idx < table.getn(valid_buffers) then
				buffername = buffername .. options.window_separator
			end

			tabname = tabname .. buffername
		end

		s = s .. tabname .. string.sub(options.padding, 1, #options.padding - 1) .. options.separator
	end

	return s .. "%#TabLineFill#%T"
end

function M.setup(user_options)
	M.options = vim.tbl_extend("force", M.options, user_options)

	function _G.nvim_tabline()
		return tabline(M.options)
	end

	vim.o.showtabline = M.options.auto_hide and 1 or 2

	vim.o.tabline = "%!v:lua.nvim_tabline()"

	vim.g.loaded_nvim_tabulous = 1
end

return M
