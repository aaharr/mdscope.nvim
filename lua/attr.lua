MarkdownFile = {}
-- MarkdownFile Class takes in a file path, parses : attributes
-- Constructor is instantiated with a file path in constructor

function MarkdownFile:new(path)
	print("Creating new MarkdownFile object from file: " .. path)
	local obj = {}
	setmetatable(obj, self)
	self.__index = self
	self.path = path
	self.attributes = {}
	return obj
end

-- Method parseAttributes reads the file and stores the attributes in a table
function MarkdownFile:parseAttributes()
	print("Parsing attributes from file: " .. self.path)
	local file = io.open(self.path, "r")
	local line = file:read()
	while line do
		if line:find(":") then
			local key, value = line:match("([^:]+):(.+)")
			if tonumber(value) then
				self.attributes[key] = tonumber(value)
			else
				self.attributes[key] = value
			end
		end
		line = file:read()
	end
	file:close()
end

-- Method prints attributes table to stdout
function MarkdownFile:printAttributes()
	for key, value in pairs(self.attributes) do
		print(key, value)
	end
end

-- Method returns the value of a given key
function MarkdownFile:getAttribute(key)
	return self.attributes[key]
end

-- Method sums the values of all integer attributes

function MarkdownFile:sumAttributes()
    local sum = 0
    for key, value in pairs(self.attributes) do
        if type(value) == "number" then
            sum = sum + value
        end
    end
    return sum
end

-- Method divides impact by effort to get "benefit" attribute, adds to table

function MarkdownFile:calculateBenefit()
    local benefit = (self.attributes["Impact"] / self.attributes["Effort"]) * 100
    self.attributes["benefit"] = benefit
    return benefit
end


--- Main ---

-- handle args
for _, v in ipairs(arg) do
	if v == "--help" then
		print("Usage: lua attr.lua <filename>")
		print("<filename>: The path to the markdown file to parse.")
		print("--help: Display this help message.")
		os.exit(0)
	end
end

--If arg1 not provided, print error message
if not arg[1] then
	print("Usage: lua attr.lua <filename>")
	os.exit(1)
end

-- Class is instantiated with arg1 as the file path or returns error
local file = MarkdownFile:new(arg[1])

file:parseAttributes()
file:printAttributes()
print("Benefit: " .. file:calculateBenefit())
