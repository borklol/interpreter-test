local number = require("class").newConstructor({}, {})

function number:add(num)
	self.value = self.value + num
	return self.value
end

function number:mul(num)
	self.value = self.value * num
	return self.value
end

function number:div(num)
	self.value = self.value / num
	return self.value
end

function number:sub(num)
	self.value = self.value - num
	return self.value
end

return number