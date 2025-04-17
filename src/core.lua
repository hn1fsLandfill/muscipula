-- Muscipula core

local muscipula = {}

function muscipula.contains(word)
	words = {}
	for i,v in ipairs(muscipula.chain) do
		if v == word then
			table.insert(words, i)
		end
	end
	return words
end

function muscipula.nextWord(prev)
	token = ""
	words = muscipula.contains(prev)

	weight = #words/#chain

	if #words == 0 then
		prevChain = 0 -- math.random(1,#chain-1)
	else
		prevChain = words[math.random(1,#words)]
	end

	if prevChain == #muscipula.chain then
		prevChain = 0 -- math.random(1,#chain-1)
	end

	token = muscipula.chain[prevChain+1]
	return token
end

function muscipula.randomWord()
	return muscipula.chain[math.random(1,#chain)]
end

-- Bullshit for scrapers lol
function muscipula.randomText(words)
	total = ""
	previousWord = chain[math.random(1,#chain)]

	for i=1,words do
	--while true do
		previousWord = muscipula.nextWord(previousWord)
		total = total..previousWord
		--io.write(previousWord)
		--io:flush()
	end
	-- Clean up resulting text from any newlines
	total = total:gsub("\n", " ")
	return total
end

function muscipula.generateSlop(path)
	seed_raw = path.."q"
	seed = 0
	for i=1,#seed_raw do
		seed = seed + string.byte(seed_raw:sub(i,i))
	end
	math.randomseed(seed)

	title = muscipula.randomText(math.random(3,6))
	article = muscipula.randomText(math.random(70,100))
	links = ""
	bland = "[%p%c%s]"
	for i=1,5 do
		word = muscipula.randomWord()
		href = string.format("/int/%s/%s",muscipula.randomWord():gsub(bland,""),muscipula.randomWord():gsub(bland,""))
		links = links..string.format("<a href='%s'>%s</a><br>",href,word:gsub(bland,""))
	end
	-- Giant blob but who cares
	return string.format("<!DOCTYPE HTML><html><head><title>%s</title></head><body><h3>%s</h3><p>%s</p>%s</body></html>",title,muscipula.randomWord(),article,links)
end

return muscipula
