local Class, Object = require("Self")(true, true)
local Person = Class {
  name = '',
  age = 0
}

function Person:new(name, age)
  self.name = name
  self.age = age
end

function Person:greet()
  print(("Hello, my name is %s and I'm %dyo"):format(self.name, self.age))
end

local a = Person("A", 34)
local b = New(Person, "B", 56)
local c = Object.new(Person, "C", 86)

print(a:is())
print(b:is(Person))
print(a:is(Object))

-- Pretty print with Luvit
if p then
  p(a)
  p(b)
  p(c)
  p(Person)
end

a:greet()
b:greet()
c:greet()