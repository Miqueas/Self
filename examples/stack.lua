local Class = require("self")
local unp = table.unpack or unpack

local Stack = Class("Stack", nil, {
  _S = { main = {} },  -- Tabla donde se almacenan las pilas
  current = "main",    -- "Espacio de nombres" en el que se trabaja actualmente
  stacks = { "main" }, -- Lista de control de pilas

  -- Constructor
  new = function (self, ...)
    local args = {...}

    if #args > 0 then
      for _, v in ipairs(args) do
        if type(v) == "string" then
          self._S[v] = {}
          table.insert(self.stacks, v)
        end
      end
    end
  end,

  -- push: coloca uno o más objetos en la pila
  push = function (self, ...)
    local args = {...}
    local current = self._S[self.current]

    if #args > 0 then
      for _, v in ipairs(args) do
        table.insert(current, v)
      end
    end
  end,

  -- pop: retira un objeto en la posición 'pos' o el último en la
  --      pila si no se especifica 'pos'
  pop = function (self, pos)
    local current = self._S[self.current]
    table.remove(current, pos)
  end,

  -- get: similar a pop, pero no retira elementos, en su lugar,
  --      retorna valores
  get = function (self, pos)
    local current = self._S[self.current]
    local last = #current
    return current[pos] or current[last]
  end,

  -- switch: cambia de espacio de nombres
  switch = function (self, name)
    assert(self._S[name], ("Stack '%s' not exists"):format(name))
    self.current = name
  end,

  -- name: retorna el (espacio de) nombre(s) de la pila actual
  name = function (self) return self.current end,
  -- len: retorna la cantidad de items en la pila
  len = function (self) return #self._S[self.current] end,
  -- unpack: wrapper para "table.unpack" o "unpack" (según la versión de Lua)
  unpack = function (self) return unp(self._S[self.current]) end,

  -- new: crea (y agrega) una nueva pila
  create = function (self, name)
    self._S[name] = {}
    table.insert(self.stacks, name)
  end,

  -- TODO: index: returns the (key or table) index of the
  --              given argument
  index = function (self, val)
  end,

  -- clear: elimina todos los items dentro de una pila
  clear = function (self, name)
    assert(self._S[name], ("Stack '%s' not exists"):format(name))
    self._S[name] = {}
  end,

  -- TODO: destroy: delete an stack from the given name
  destroy = function (self, name)
  end,

  -- list: retorna los nombres de todas las pilas
  list = function (self) return unp(self.stacks) end,
  -- __len (metamethod): llama al método "len" cuando el operador # es
  --                     usado
  __len = function (self) return self:len() end
})

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

print("Stacks:")
print(things:list())
print()

things:switch("animales")

for _, v in ipairs(animales) do
  things:push(v)
end

print("Todos los animales:")
print(things:unpack())
print()

things:switch("personas")

for _, v in ipairs(personas) do
  things:push(v)
end

print("Todas las personas:")
print(things:unpack())