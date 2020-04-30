require("ecls.stack")

local things = Stack("animales", "personas")
local animales = {
  "perro",
  "gato",
  "elefante"
}

local personas = {
  "juan",
  "maría",
  "pedro"
}

--print("Stacks:")
--print(things:list())

things:switch("animales")

for _, v in ipairs(animales) do
  things:push(v)
end

--print("Todos los animales:")
--print(things:unpack())

things:switch("personas")

for _, v in ipairs(personas) do
  things:push(v)
end

--print("Todas las personas:")
--print(things:unpack())

--things:destroy("personas")

--print("Stacks:")
--print(things:list())

for k, v in pairs(things) do print(k, v) end