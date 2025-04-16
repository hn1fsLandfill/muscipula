-- Basically split the dataset into tokens
local chaingen = {}

function chaingen.import(data)
	chain = {}
	i = 0
	while true do
		oldI = i
		i = string.find(data," ", i+1)
		if i == nil then
			break
		end
		table.insert(chain,data:sub(oldI+1,i))
	end
	return chain
end

return chaingen
