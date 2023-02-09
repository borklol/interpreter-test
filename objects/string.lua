local string = require("class").newConstructor({}, {_txtContent = ""})

local uppercase = 
{
	["A"] = "a",
	["B"] = "b",
	["C"] = "c",
	["D"] = "d",
	["E"] = "e",
	["F"] = "f",
	["G"] = "g",
	["H"] = "h",
	["I"] = "i",
	["J"] = "j",
	["K"] = "k",
	["L"] = "l",
	["M"] = "m",
	["N"] = "n",
	["O"] = "o",
	["P"] = "p",
	["Q"] = "q",
	["R"] = "r",
	["S"] = "s",
	["T"] = "t",
	["U"] = "u",
	["V"] = "v",
	["W"] = "w",
	["X"] = "x",
	["Y"] = "y",
	["Z"] = "z",
}

local function reverseTable(tbl)
	local newT = {}
	for i, v in pairs(tbl) do
		newT[v] = i
	end
	return newT
end

local lowercase = reverseTable(uppercase)

function string:toUpper()
	local newS = ""
	for i = 1, self.value:len() do
		if (tostring(self.value:sub(i, i))) then
			local char = self.value:sub(i, i)
			char = lowercase[char]
			if (char) then
				newS = newS .. char
			else
				newS = newS .. self.value:sub(i, i)
			end
		end
	end
	self.value = newS
	return newS
end

function string:toLower()
	local newS = ""
	for i = 1, self.value:len() do
		if (tostring(self.value:sub(i, i))) then
			local char = self.value:sub(i, i)
			char = uppercase[char]
			if (char) then
				newS = newS .. char
			else
				newS = newS .. self.value:sub(i, i)
			end
		end
	end
	self.value = newS
	return newS
end

return string