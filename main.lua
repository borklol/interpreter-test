
local function readFile(file)
	local file = io.open(file, "rb")
	return file:read("*all")
end

local input = readFile("example.ccarley")

function string.split(s, delimiter)

	local lastSplitter = 0
	local tmp = {}

	for i = 1, input:len() do
		if (s:sub(i, i) == delimiter or s:sub(i, i) == "\n") then
			tmp[#tmp+1] = s:sub(lastSplitter+1, i-1)
			lastSplitter = i
		end
	end
	tmp[#tmp+1] = s:sub(lastSplitter+1, -1)

	return tmp
end

function GetObject(name)
	return Variables[name]
end

function table.find(tbl, v2)
	for _, v in pairs(tbl) do
		if (v == v2) then
			return _
		end
	end
end

local function evaluate(line)
	local split = ""

	for i = 1, line:len() do
		if (line:sub(i, i) == ":") then
			split = line:sub(i+1, string.len(line))
			break
		end
	end

	return split
end

function RemoveSpaces(str)
	local temp = ""

	for i = 1, str:len() do
		if (str:sub(i, i) ~= " ") then
			temp = temp .. str:sub(i, i)
		end
	end

	return temp
end

local parser = require("Parser").new()
Variables = {}

local startTime = os.clock()
for _, text in ipairs(string.split(input, ";")) do
	local split = string.split(text, " ")
	for i, info in ipairs(split) do
		local splitFunction = string.split(info, "(")

		if (parser.objects[info] and i == 1) then
			local a = parser.objects[info](split[i + 1]:sub(1, string.len(split[i+1])-1), evaluate(text))
			if (type(a) == "table") then
				Variables[split[i + 1]:sub(1, string.len(split[i+1])-1)] = a
			else
				error(a)
			end
		elseif (parser.functions[splitFunction[1]] and i == 1 and string.match(splitFunction[1], ":")) then
			local startS, endS = string.find(splitFunction[1], ":")
			info = string.split(info, "(")
			info[#info] = info[#info]:sub(0, string.len(info[#info])-1)
			local args = string.split(info[2], ",")

			if (Variables[string.sub(splitFunction[1], 0, endS-1)]) then

				for _, txt in ipairs(args) do
					--txt = RemoveSpaces(txt)
					if (Variables[txt]) then
						args[_] = Variables[txt].value
					end
				end

				parser.functions[splitFunction[1]](Variables[string.sub(splitFunction[1], 0, endS-1)], unpack(args))
			else
				error("Indexing a nil variable.")
			end

		elseif (parser.functions[splitFunction[1]] and i == 1) then
			info = string.split(info, "(")
			info[#info] = info[#info]:sub(0, string.len(info[#info])-1)
			local args = string.split(info[2], ",")

			for _, txt in ipairs(args) do
				txt = RemoveSpaces(txt)
				--print(txt)
				if (Variables[txt]) then
					args[_] = Variables[txt].value
				end
			end

			parser.functions[splitFunction[1]](unpack(args))
		end
	end
end
print("Time taken: " .. os.clock()-startTime)

--[[
for name, type in pairs(Variables) do
	print("Name: ".. name, "Value: ".. type.value, "Type: ".. type.ClassName)
end--]]