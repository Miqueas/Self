# Ecls
### Easy classes for Lua!

Ecls es una librería simple para manejo de clases en Lua. Basada en [luaclass](https://github.com/benglard/luaclass)

## Uso

Simplemente importe la librería en el ámbito global:

```lua
require("ecls")
```

## Ejemplos

Cuando Ecls es importado, se retorna la función `Class`, con la cual podrás crear tus clases:

```lua
require("ecls")

Class("Car", {
  model = 'none',
  maker = 'none',

  __init__ = function (self, model, maker)
    self.model = model or "Mustang"
    self.maker = maker or "Ford"
  end,

  on = function (self)
    print(("The %s is ready for run!"):format(self.model))
  end,

  off = function (self)
    print(("Time to sleep..."))
  end,

  run = function (self)
    print("Speeddd!!!")
  end
})

local mustang = Car()
mustang:on()
mustang:run()
mustang:off()
```

Ecls también soporta herencia, así que, siguiendo el ejemplo anterior, puedes hacer esto:

```lua
Class("Camaro", {
  model = "Camaro",
  maker = "Chevrolet",
  status = "off"

  on = function (self)
    self.status = "on"
    print(("The %s is ready for run!"):format(self.model))
  end,

  off = function (self)
    self.status = "off"
    print(("Time to sleep..."))
  end,

  run = function (self)
    if self.status == "off" then
      error("The Camaro is off!")
    else
      print("Oh boi, this Camaro is very fassssst!")
    end
  end
}, Car)

local camaro = Camaro()
camaro:run()
```

## `set` y `get`

Cuando creas una clase con ecls, automáticamente un método `set` y `get` son añadidos a ésta.
Sin embargo, ten en cuenta que son métodos bastante básicos y que podrían no funcionar como
se espera. Por otro lado, el comportamiento de estos mismos pueden ser modificados en el cuerpo
de la clase tal cual como:

```lua
Class("Foo", {
  k = "key",
  v = "val",

  set = function (self)
    -- body
  end,

  get = function (self)
    -- body
  end
})

local f = Foo()
local v = f:get('k')
f:set('v', "some value")
print(f:get('v'))
```