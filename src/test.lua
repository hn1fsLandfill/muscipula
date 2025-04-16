local chaingen = require("chaingen")
local core = require("core")

dataset_file = io.open("data","r")
dataset = dataset_file:read("a")
dataset_file:close()

core.chain = chaingen.import(dataset)

print(core.randomText(10))
