# Ecls
### Easy classes for Lua!

Ecls es una librería simple para manejo de clases en Lua. Basada en [luaclass](https://github.com/benglard/luaclass)

## Uso

Simplemente importe la librería en el scope global:

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
    return self
  end,

  on = function (self)
    print(("The %s is ready for run!"):format(self.model))
  end,

  off = function (self)
    print(("Time to sleep..."))
  end,

  run = function (self)
    print("So FASSSSSTT!!!")
  end
})

local mustang = Car()
mustang:on()
mustang:run()
mustang:off()
```

Ecls también soporta herencia, así que, siguiendo el ejemplo anterior, puedes hacer esto:

```lua

```