¡Hey! ¿Buscas una versión en Español? ¡Revisa [aquí](https://github.com/M1que4s/self/blob/master/README_es.md)!

# Self

A very simple and compact OOP (Object Oriented Programming) library for Lua 5+

## Usage

Self returns a father class named "Object" that we need to store into a variable. You can store it as you please

```lua
local Class = require("self")
```

Now we are ready to go! To create a class we just do this:

```lua
local Point = Class("Point")
```

And there you go! There is a class with "Point" as a name saved into a local variable named like so.
The problem is, we need to make a constructor for it!

```lua
function Point:new(x, y)
  self.x = x or 0
  self.y = y or 0
end
```

The constructor needs to be always `new(...)` or `init(...)`, otherwise, the program will crash.
With our constructor already defined, we can start creating instances and experiment with our creation.

```lua
local p = Point(20, 40)
```

## Documentation

The father class (the one returned by the library) only contains 5 methods. Go check `examples/`

#### `create([name, parent, def, G])`

Creates a new class inherited from the father class I already mentioned. `Class(...)` is the same as `Class:create(...)`

Arguments (optional):

 - (__string__)  `name`   The class name, is used as convenience for the `dump()` method, but it can be very useful to name classes.
 - (__class__)   `parent` A parent class that our class will be inherited of.
 - (__table__)   `def`    The class definition (including ALL methods).
 - (__boolean__) `G`      If the class should be stored globally, in this case, this function wont return anything

#### `uses(...)`

Implements methods of other classes into your class. This is used in new classes. This method wont make your class be inherited from another(s).

Arguments:

 - (__class__) `...` An undefined amount of classes, at least 1 is expected.

#### `is(class)`

Returns `true` if your class is (or is inerithed from) `class`

Arguments:

 - (__class__) `class` a-... a class... but not an instance of class

### `isClass(obj)`

Returns `true` if `obj` is a class.

Arguments:

 - (__table__) `obj` The table that is checked. Returns `nil` otherwise

#### `dump([details, indent])`

Creates an estimate aproximation of all the data inside your class.

Arguments (optional):

 - (__boolean__) `details` If this method is called from an instance, use this to show the CLASS data instead
 - (__string__)  `indent`