# Self

Una librería simple y compacta de OOP para Lua.

## Uso

Self retorna una clase padre llamada "Object", la cual necesitaremos guardar en una variable. Por gustos personales, la guardo en "Class", pero eres libre de hacerlo como desees.

```lua
local Class = require("self")
```

Hecho eso, ya podemos empezar a crear clases. Para eso, podemos simplemente hacer lo siguiente:

```lua
local Point = Class("Point")
```

Con eso, ya tenemos nuestra clase, sin embargo, es necesario definir un constructor:

```lua
function Point:new(x, y)
  self.x = x or 0
  self.y = y or 0
end
```

El contructor de clase siempre debe ser `new(...)` o `init(...)`, de lo contrario tendrá un error. Con el constructor ya definido, podemos crear una nueva instancia y empezar a trabajar con ella:

```lua
local p = Point(20, 40)
```

## Documentación

La clase Object provee solo 4 métodos, los cuales se explican aquí brevemente. Puede ver la carpeta `examples/` para más detales.

#### `create([name, parent, def, G])`

Crea una nueva clase que hereda de Object. `Class(...)` es lo mismo que `Class:create(...)`.

Argumentos (opcionales):

 - (__string__)  `name`   El nombre de la clase, es solo por conveniencia para el método `dump()`, pero también te puede ser de utilidad para identificar sus clases.
 - (__class__)   `parent` Una clase que será usada como padre/base para la nueva clase.
 - (__table__)   `def`    La definición de la clase, con todos sus métodos (incluído el constructor).
 - (__boolean__) `G`      Clase global. En este caso, el primer parámetro se hace obligatorio y
                      la clase no se retorna, en su lugar, es anexado a `_G` siempre y cuando no
                      exista una clase del mismo nombre.

#### `uses(...)`

Implementa funciones de otras clases en una nueva clase. Se usa en nuevas clases. Éste método no hace que una clase herede de otra(s).

Argumentos:

 - (__class__) `...` Una cantidad indefinida de clases. Se espera al menos 1 clase.

#### `is(cls)`

Retorna `true` si la instancia es del mismo tipo que (o hereda de) `cls`.

Argumentos:

 - (__class__) `cls` Una clase (duh...)

#### `dump([details, indent])`

Crea una representación aproximada en texto de una clase o una instancia.

Argumentos (opcionales):

 - (__boolean__) `details` Si el método es llamado desde una instancia, use `true` para ver
                       los detalles de la clase en su lugar.
 - (__string__)  `indent`