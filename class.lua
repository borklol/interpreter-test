local class = {}

function class.new(settings)
	settings.__index = settings
	return settings
end

function class.newConstructor(original, args)
	original = class.new(original)

	original.new = function(args)
		return class.construct(original, args or {})
	end
	return original
end

function class.construct(original, args)
	return setmetatable(args, original)
end

return class