# Self

Una librería simple y compacta de OOP para Lua.

### Uso básico

Aquí un ejemplo rápido de como usarla:

```lua
local Class = require("Self") -- Cargamos la librería
local Point = Class("Point") -- Creamos nuestra clase

function Point:new(x, y) -- Definimos un constructor
  self.x = x or 0
  self.y = y or 0
end

local p = Point(10, 40) -- Ahora 'p' es una instancia de la clase 'Point'
```

Lee la documentación [aquí](Docs_es.md)

---

Self sigue la especificación de [SemVer](https://semver.org/)