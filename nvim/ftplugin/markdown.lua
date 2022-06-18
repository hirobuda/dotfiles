-- insert mode remaps
norm_table = {'(', ')', '[', ']', '\\part', '\\the', '\\alp', '\\bet', '\\fr', '\\sum', '^', '_', '\\pd', '\\lim', '\\int'}
math_table = {'\\left(', '\\right)', '\\left[', '\\right]', '\\partial', '\\theta'
, '\\alpha', '\\beta', '\\frac{}{}', '\\sum_{}^{}', '^{}', '_{}', '\\frac{\\partial}{\\partial}', '\\lim_{\\to}',
'\\int_{}^{}'
}
keymap_table = {}

n = #norm_table

for i=1,n do
	keymap_table[norm_table[i]] = math_table[i] 
end

function isMath(k)
 	local groups = " "
	for _,val in pairs(vim.fn.synstack(vim.fn.line("."), vim.fn.col("."))) do
		groups = groups .. vim.fn.synIDattr(val, "name") .. " "
	end
	if string.find(groups, "Math") ~= nil then
		return keymap_table[k]
	end
	return k
end

for i = 1,n do
	vim.keymap.set('i', norm_table[i], function() return isMath(norm_table[i]) end, {buffer=true, expr=true})
end

--normal mode remaps:

vim.keymap.set('n', '<F2>', 'i$$<Enter>\\begin{aligned}<Enter><Enter>\\end{aligned}<Enter>$$', {buffer=true})
