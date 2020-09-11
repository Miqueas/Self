# Documentation

In this file you will find the documentation for `Self.lua` and `Stack.lua`

## Self

To start working with Self, it's simple as using `require("Self")` and save it in a variable as you can see in the README. There are 2 ways to create a class with Self and in theory, it should work the same in both cases:

1. First declare and then define:
```lua
local Class = require("Self")
local Person = Class("Person")
Person.name = "None" -- A property

function Person:new(...) -- Constructor
  -- ...
end

-- Other methods here...
```

2. Declare and define at the same time:
```lua
local Class = require("Self")
local Person = Class("Person", nil, {
  name = "None",

  new = function (self, ...)
    -- ...
  end

  -- Other methods here...
})
```

It is mainly an aesthetic difference, but some may find one or the other more comfortable.

When we load Self, we are actually loading the parent class "Object", which contains several methods for working OOP in Lua. All classes inherit from Object and Object inherits from itself. This class provides, for now, only 5 methods:

  * `create([name, parent, def, G])`: Creates a new class. `Class(...)` does the same as `Class:create(...)`. Arguments:
    - (__string__)  `name`   The name of the class, required if 'G' is indicated.
    - (__class__)   `parent` Parent class.
    - (__table__)   `def`    Body/class definition.
    - (__boolean__) `G`      Global class. It is not returned, instead, the class is put in `_G` as long as there is not one with the same name.

  * `uses(...)`: Implements/imports methods (functions) from other class(es) Arguments:
    - (__class__) `...` One or more classes (at least one is expected)
    - By example:
      ```lua
      local Point2 = Class("Point2")
      -- ...
      local Point3 = Class("Point3")
      Point3:uses(Point2)
      ```

  * `is(cls)`: Return `true` if the instance is of the class (or inherits from) `cls`. Arguments:
    - (__class__) `cls` A class (not an instance).
    - By example:
      ```lua
      local Person = Class("Person")
      -- ...
      local me = Person()
      print(me:is(Person)) --> true
      ```

  * `isClass(obj)`: Return 'true' if the argument received is a class. Arguments:
    - (__table__) `obj` A table. If it receives a different value, it returns 'nil'.
    - By example:
      ```lua
      -- ...
      print(Class:isClass({})) --> false
      -- ...
      ```

  * `dump([details, indent])`: Creates a rough representation in text of a class or an instance. Arguments:
    - (__boolean__) `details` If the method is called from one instance, use `true` to see the details of the class instead.
    - (__string__)  `indent` One or more characters shown at the beginning of each line.
    - By example:
      ```lua
      -- ...
      local s = Stack()
      print(s:dump()) --[[ Output:
      Stack = {}
      ]]

      print(s:dump(true, "=> ")) --[[ Output:
      => Stack = {
      =>   -- Lots of lines of text here...
      => }
      Stack["__index"] = Stack
      Stack["__parent"][1]["__parent"][1] = Stack["__parent"][1]
      Stack["__parent"][1]["__index"] = Stack["__parent"][1]
      ]]
      ```

## Stack

Stack (.lua) is a utility class to work with stacks in Lua in an easy, fast and simple way. It must be explicitly imported with 'require', since it is not imported with Self. Each instance of the class can handle several stacks. Like Self, its use is quite simple:

```lua
local Stack = require("Stack")
local things = Stack()

for k, v in pairs({'a', 'b', 'c', 'd', 'e', 'f', 'g'}) do things:push(v) end
print(things:len()) --> 7
```

This class has a wide variety of methods:

  * `new(...)`: Constructor. Same as `Stack()`. Arguments:
    - (__string__) `...` One or more names for different stacks.

  * `push(...)`: Add one or more things to the current stack. Arguments:
    - (__any__) `...` Anything...

  * `pop(pos)`: Remove an element from the current stack at the `pos` position.
    - (__number__) `pos` Index of the value to be removed. If no value is indicated, then remove the last added.

  * `get(pos)`: Similar to `pop`, but returns the value instead of removing it.
    - (__number__) `pos` Index. Returns the last added if not.

  * `switch(name)`: Switch to another stack. Arguments:
    - (__string__) `name` Name of new active stack.

  * `name()`: Returns the name of the active stack.

  * `len()`: Returns the total number of elements in the current stack.

  * `unpack()`: Similar to `table.unpack`. Works on the active stack.

  * `create(name)`: Create a new stack. Arguments:
    - (__string__) `name` Name of the new stack.

  * `clear(name)`: Clean/empty a stack. Arguments:
    - (__string__) `name` Name of the stack. If not indicated, then the current stack is cleared.

  * `list()`: Returns the names of all the stacks.

  * `index(val)`: Returns the index of a value in the current stack.
    - (__any__) `val` A value that is in the stack.

  * `destroy(name)`: Destroy a stack (becomes `nil`). Arguments:
    - (__string__) `name` Name of the stack. If not indicated, it destroys the current stack.