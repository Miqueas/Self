local Class, Object = require("Self")(true, true)
local Person = Class {
  name = '',
  age = 0
}

function Person:new(name, age)
  self.name = name
  self.age = age
end

local a = Person("A", 34)
local b = New(Person, "B", 56)
local c = Object.new(Person, "C", 86)
print(a.name)
print(b.name)
print(c.name)
print(a.age)
print(b.age)
print(c.age)

p(a)
p(b)
p(c)
p(Person)

c.cock = 2
p(c)
p(c == c)
p(a)
p(b)
p(Person)