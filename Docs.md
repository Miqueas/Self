# Documentation

Self is intended to be simple, fast and easy to use. The difference between Self and others OOP libraries is mainly in the design/features:

  - All clases inherits directly from `Object`
  - Inheritance isn't supported ***at all*** (I'll try to explain this later)
  - At the moment, custom `__index` and `__newindex` metamethods aren't supported
  - There's an optional global constructor function called `New` (offering an C#/Java-like syntax)
  - Tries to generate clean tables (no `_thing` or `__thing` crap)
  - More """realistic""" OOP

At the moment, there's not much to say about Self:

```lua
local class = require("Self")
local Car = class {
  model = '',
  manufacturer = ''
}

function Car:new(manufacturer, model)
  self.manufacturer = manufacturer
  self.model = model
end

function Car:start(...)
  -- ...
end

local fordFiesta = Car("Ford", "Fiesta")
```

## Installing Self

You can either use Luarocks or just download [Self.lua](Self.lua) and put it in your project.

### What about `Stack.lua`?

`Stack.lua` is just a simple implementation of the stack data structure that I made a while ago. Self doesn't require it, but if you like it, you're free to use it. You can `require()` it by like:

```lua
local stack = require("Self.Stack")
```

If you installed Self with Luarocks.

## About inheritance

With the recent changes (since this [commit][commit]) in Self, I have removed the support for inheritance. Instead, I'm trying to use a composition-like focus, so now inheritance is basically the same as implementing a set of functions into a class, keeping all the classes/objects with just one parent: `Object`. I made that because supporting inheritance sometimes is a pain in the ass:

  - Performance issues
  - Hard to mantain
  - ***M  e  t  a  t  a  b  l  e  s***

Well, it can depend on how is implemented... But still is a pain in the ass.

So... *"How I can **implement** functions in my class?"*. Well, that's quite simple:

```lua
local class = require("Self")

local MyFunctions = {
  a = function()
    -- ...
  end

  -- ...
}

local MyClass = Class {
  -- ...
}

MyClass:implements(MyFunctions)
```

You can also pass another class (by example):

```lua
-- ...
MyClass:implements(ClassA, ClassB, ClassC)
```

And isn't required to pass one by one, the `implements` functions accepts an undefined number of arguments.

## The `class` function

This is the main function to get OOP done with Self, the table that u pass to this function is used like a "template" or "blueprint". By example:

```lua
local class = require("Self")
local Person = class { name = "" }

function Person:new(name)
  self.name = name
end

function Person:greet()
  print(("Hello, my name is %s!"):format(self.name))
end

local me = Person("Miqueas")
-- This will throw an error, because there's no `age` property (it wasn't
-- declared in the 2nd line) and allows to prevent pushing unexpected
-- things in objects.
me.age = 21
```

## Object _immutability_

Self objects (class instances) are, in a sense, inmutable. As you saw above, you can only write existing properties in an object. For methods is a bit different: you can't overwrite methods from an object. By example (following the above person example):

```lua
-- ...

-- This will throw an error
me.greet = 29
```

This is the reason why (at the moment) there's no way to support custom `__index` and `__newindex` metamethods, because this behavior is handled using these metamethods.

[commit]: https://github.com/Miqueas/Self/commit/575093ae9f53fe67c930543891cd117410235993