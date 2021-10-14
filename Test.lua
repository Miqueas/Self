local Class = require("Self")
local Stack = require("Stack")
local Person = Class()

function Person:__ctor(name, age)
  self.name = name
  self.age = age
end

local a = Person("A", 39)
local b = Person("B", 24)
local s = Stack()

s:push(math.pi)

p(a)
p(b)
p(s)
p(Person)
p(Stack)

p(a == Person)
p(b == Person)
p(s == Stack)