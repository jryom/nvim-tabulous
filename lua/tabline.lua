local M = {}

local function predicate(buffer)
	return vim.bo[buffer].buftype ~= "nofile"
end

local function tabline()
	local s = ""

	for tab_nr = 1, vim.fn.tabpagenr("$") do
		if tab_nr == vim.fn.tabpagenr() then
			s = s .. "%#TabLineSel#"
		else
			s = s .. "%#TabLine#"
		end

		s = s .. "   "
		s = s .. "%" .. tab_nr .. "T"
		s = s .. tab_nr .. ". "

		local tabname = ""

		local valid_buffers = {}

		for _, buf_nr in ipairs(vim.fn.tabpagebuflist(tab_nr)) do
			if predicate(buf_nr) then
				table.insert(valid_buffers, buf_nr)
			end
		end

		for idx, buf_nr in ipairs(valid_buffers) do
			local buffername = vim.api.nvim_buf_get_name(buf_nr)
			local buftype = vim.bo[buf_nr].buftype

			if buftype == "help" then
				buffername = vim.fn.fnamemodify(buffername, ":t:s/.txt$/ /") .. "[H]"
			elseif buftype == "quickfix" then
				buffername = buffername .. "[Q]"
			elseif buffername == "" then
				buffername = "[No Name]"
			else
				buffername = vim.fn.fnamemodify(buffername, ":t")
			end

			if vim.bo[buf_nr].modified then
				buffername = buffername .. " +"
			end

			if idx < table.getn(valid_buffers) then
				buffername = buffername .. " | "
			end

			tabname = tabname .. buffername
		end

		s = s .. tabname .. "  ▕"
	end

	return s .. "%#TabLineFill#%T"
end

function M.setup()
	function _G.nvim_tabline()
		return tabline()
	end

	vim.o.showtabline = 1
	vim.o.tabline = "%!v:lua.nvim_tabline()"

	vim.g.loaded_nvim_tabulous = 1
end

return M
