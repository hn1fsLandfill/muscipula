-- Muscipula core

local muscipula = {}

muscipula.config = {}
-- Activate "fancy" mode and appear as an blog to unsuspecting scrapers.
muscipula.config.beFancy = true
-- Minimum amount of words for an generated article
muscipula.config.minText = 70
-- Maximum amount of words for an generated article
muscipula.config.maxText = 100

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

	if #words == 0 then
		prevChain = math.random(1,#chain-1)
	else
		prevChain = words[math.random(1,#words)]
	end

	if prevChain == #muscipula.chain then
		prevChain = math.random(1,#chain-1)
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
		previousWord = muscipula.nextWord(previousWord)
		total = total..previousWord
	end
	-- Clean up resulting text from any newlines
	total = total:gsub("\n", " ")
	return total
end

-- Basic theme
local basic = "<!DOCTYPE HTML><html><head><title>%s</title></head><body><h3>%s</h3><p>%s</p>%s</body></html>"
-- "Fancy" theme, makes the webpage look more "realistic" to suspecting scrapers.
local fancy = "<!DOCTYPE HTML><html><head><title>%s</title><meta name=\"title\" content=\"Article\"><meta name=\"description\" content=\"%s\"><meta property=\"og:type\" content=\"website\"><meta property=\"og:title\" content=\"Article\"><meta property=\"og:description\" content=\"%s\"><style>body {color:black;font-family:monospace;font-size: 16px;line-height:1.4;} #app {padding: 0px 16px 0px 16px;}</style></head><body><div id=\"app\"><h2>%s</h2><p>%s</p><h3>Related Articles</h3>%s</div></body></html>"


function muscipula.generateSlop(path,dirpath)
	if dirpath == nil then
		dirpath = ""
	end

	seed = 0
	for i=1,#path do
		seed = seed + string.byte(path:sub(i,i))
	end
	math.randomseed(seed)

	title = muscipula.randomText(math.random(3,6))
	article = muscipula.randomText(math.random(muscipula.config.minText,muscipula.config.maxText))
	links = ""
	bland = "[%p%c%s]"
	for i=1,5 do
		word = muscipula.randomWord()
		href = string.format("%s/%s/%s",dirpath,muscipula.randomWord():gsub(bland,""),muscipula.randomWord():gsub(bland,""))
		links = links..string.format("<a href='%s'>%s</a><br>",href,word:gsub(bland,""))
	end
	if muscipula.config.beFancy then
		return string.format(fancy,title,title,title,muscipula.randomWord(),article,links)
	end
	return string.format(basic,title,muscipula.randomWord(),article,links)
end

return muscipula
