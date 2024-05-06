local class = require("Self")
local Person = class {
  name = "",
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
local b = Person("B", 56)
local c = Person("C", 86)

print(a:is())
print(b:is(Person))

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