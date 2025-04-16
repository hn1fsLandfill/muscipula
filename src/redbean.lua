local chaingen = require("chaingen")
local core = require("core")

core.chain = chaingen.import(LoadAsset("/data"))

function OnHttpRequest()
	SetStatus(200)
	body = core.generateSlop(GetPath())
	chunkSize = 64
	for i=1, #body, chunkSize do
		Write(body:sub(i,i+chunkSize-1))
		coroutine.yield()
		Sleep(1)
	end
end
