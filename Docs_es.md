# Documentación

En este fichero podrás encontrar la documentación de `Self.lua` y `Stack.lua`

## Self

Para empezar a trabajar con Self, es simple como usar `require("Self")` y guardarlo en una variable tal y como se puede ver en el README. Hay 2 formas de crear una clase con Self y en teoría, debería de funcionar igual en ambos casos:

  1. Primero declarar y luego definir:

    ```lua
    local Class = require("Self")
    local Person = Class("Person")
    Person.name = "None" -- Una propiedad

    function Person:new(...) -- Constructor
      -- ...
    end

    -- Otros métodos aquí...
    ```

  2. Declarar y definir al mismo tiempo:

    ```lua
    local Class = require("Self")
    local Person = Class("Person", nil, {
      name = "None",

      new = function (self, ...)
        -- ...
      end

      -- Otros métodos aquí...
    })
    ```

Es una diferencia principalmente estética, pero puede que para algunos sea más cómodo uno u otro.

Cuando cargamos Self, realmente estamos cargando la clase padre "Object", que contiene varios métodos para trabajar OOP en Lua. Todas las clases heredan de Object y Object hereda de sí mismo. Ésta clase provee, por ahora, solo 5 métodos:

  1. `create([name, parent, def, G])`: Crea una nueva clase. `Class(...)` hace lo mismo que `Class:create(...)`. Argumentos:
    - (__string__)  `name`   El nombre de la clase, obligatorio si se indica `G`.
    - (__class__)   `parent` Clase padre.
    - (__table__)   `def`    Cuerpo/definición de la clase.
    - (__boolean__) `G`      Clase global. No se retorna, en su lugar, la clase es puesta en `_G` siempre y cuando no exista una con el mismo nombre.

  2. `uses(...)`: Implementa/importa métodos (funciones) de otra(s) clase(s). Argumentos:
    - (__class__) `...` Una o más clases (se espera al menos una).
    - Ejemplo:
      ```lua
      local Point2 = Class("Point2")
      -- ...
      local Point3 = Class("Point3")
      Point3:uses(Point2)
      ```

  3. `is(cls)`: Retorna `true` si la instancia es de la clase (o hereda de) `cls`. Argumentos:
    - (__class__) `cls` Una clase (no una instancia).
    - Ejemplo:
      ```lua
      local Person = Class("Person")
      -- ...
      local me = Person()
      print(me:is(Person)) --> true
      ```

  4. `isClass(obj)`: Retorna `true` si el argumento recibido es una clase. Argumentos:
    - (__table__) `obj` Una tabla. Si recibe un valor diferente, retorna `nil`.
    - Ejemplo:
      ```lua
      -- ...
      print(Class:isClass({})) --> false
      -- ...
      ```

  5. `dump([details, indent])`: Crea una representación aproximada en texto de una clase o una instancia. Argumentos:
    - (__boolean__) `details` Si el método es llamado desde una instancia, use `true` para ver los detalles de la clase en su lugar.
    - (__string__)  `indent` Uno o más carácteres que se muestran al principio de cada línea.
    - Ejemplo:
      ```lua
      -- ...
      local s = Stack()
      print(s:dump()) --[[ Salida:
      Stack = {}
      ]]

      print(s:dump(true, "=> ")) --[[ Salida:
      => Stack = {
      =>   -- Muchas líneas de texto aquí...
      => }
      Stack["__index"] = Stack
      Stack["__parent"][1]["__parent"][1] = Stack["__parent"][1]
      Stack["__parent"][1]["__index"] = Stack["__parent"][1]
      ]]
      ```

## Stack

Stack (.lua) es una clase utilitaria para trabajar con stacks en Lua de manera fácil, rápida y simple. Debe importarse explícitamente con `require`, ya que no es importada con Self. Cada instancia de la clase puede manejar varios stacks. Al igual que Self, su uso es bastante sencillo:

```lua
local Stack = require("Stack")
local things = Stack()

for k, v in pairs({'a', 'b', 'c', 'd', 'e', 'f', 'g'}) do things:push(v) end
print(things:len()) --> 7
```

Esta clase cuenta con una amplia variedad de métodos:

  1. `new(...)`: Constructor. Igual que `Stack()`. Argumentos:
    - (__string__) `...` Uno o más nombres para diferentes stacks.

  2. `push(...)`: Agrega una o más cosas al stack actual. Argumentos:
    - (__any__) `...` Lo que sea...

  3. `pop(pos)`: Retira un elemento del stack actual en la posición `pos`.
    - (__number__) `pos` Índice del valor a remover. Si no se indica un valor, entonces retira el último agregado.

  4. `get(pos)`: Similar a `pop`, pero retorna el valor en lugar de removerlo.
    - (__number__) `pos` Índice. Retorna el último agregado en caso contrario.

  5. `switch(name)`: Cambia a otro stack. Argumentos:
    - (__string__) `name` Nombre del nuevo stack activo.

  6. `name()`: Retorna el nombre del stack activo.

  7. `len()`: Retorna el número total de elementos en que hay en el stack actual.

  8. `unpack()`: Similar a `table.unpack`. Funciona sobre el stack activo.

  9. `create(name)`: Crea un nuevo stack. Argumentos:
    - (__string__) `name` Nombre del nuevo stack.

  10. `clear(name)`: Limpia/vacia un stack. Argumentos:
    - (__string__) `name` Nombre del stack. Si no se indica, entonces se limpia el stack actual.

  11. `list()`: Retorna los nombres de todos los stacks.

  12. `index(val)`: Retorna el índice de un valor en el stack actual.
    - (__any__) `val` Un valor que se encuentra en el stack.

  13. `destroy(name)`: Destruye un stack (pasa a ser `nil`). Argumentos:
    - (__string__) `name` Nombre del stack. Si no se indica, destruye el stack actual.