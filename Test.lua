local Class = require("Self")()
local Person = Class { }

function Person:new(name, age)
  self.name = name
  self.age = age
end

local a = Person("A", 34)
local b = Person("B", 53)
print(a.name)
print(b.name)
print(a.age)
print(b.age)