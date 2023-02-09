local Parser
Parser = require("class").new({objects = {
				["string"] = function(varName, eql)
					if not string.match(eql, [["]]) then
						return "Must provide a valid string!"
					end

					local split = string.split(eql, [["]])
					eql = split[2]

					local string = require("objects/string").new()
					string._txtContent = eql
					string.name = varName
					string.value = eql
					string.ClassName = "string"

					for _, v in pairs(require("objects/string")) do
						Parser.functions[string.name .. ":" .._] = v
					end

					return string
				end,
				["number"] = function(varName, eql)

					local num = require("objects/number").new()
					num.name = varName
					num.value = tonumber(eql)
					num.ClassName = "number"

					for _, v in pairs(require("objects/number")) do
						Parser.functions[num.name .. ":" .. _] = v
					end

					return num
				end,
				["boolean"] = function(varName, eql)

					local num = {}
					num.name = varName
					num.value = RemoveSpaces(tostring(eql))
					num.ClassName = "boolean"

					return num
				end,
			}, functions = {
				print = function(...)
					print(...)
				end,
				throw = function(arg1, arg2)
					if (arg1 ~= "true" and arg1 ~= "false") then error("Provided argument is not a boolean") return end
					assert(not arg1, arg2)
				end
			}})

function Parser.new()
	local self = setmetatable({}, Parser)
	
	return self
end

return Parser