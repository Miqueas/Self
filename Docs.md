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
local Class = require("Self")()
local Car = Class {
  model = '',
  manufacturer = ''
}

function Car:new(model, manufacturer)
  self.model = model
  self.manufacturer = manufacturer
end

function Car:start(...)
  -- ...
end

local ford_car = Car("Fiesta", "Ford")
```

## Loading Self

When you "require()" Self, it returns a function that allows you to enable/disable 2 features:

  - Global `New`
  - Global `Object`

That returned function accepts two booleans parameters that enable/disable the above features in exactly that order:

```lua
-- Enables `New`
local Class = require("Self")(true)
-- Enables `New` and `Object` (and returns it)
local Class2, Object = require("Self")(true, true)
```

The `New` function allows you to do things like this (following the car example):

```lua
-- ...
local ford_car = New(Car, "Fiesta", "Ford")
```

Is just a thing to add a C#/Java-like syntax. In the other side, `Object` is the base class of all classes in Self. At the moment it doesn't have too much interesting things.

## About inheritance

With the recent changes (since this [commit][commit]) in Self, I have removed the support for inheritance. Instead, I'm trying to use a composition-like focus, so now inheritance is basically the same as implementing a set of functions into a class, keeping all the classes/objects with just one parent: `Object`. I made that because supporting inheritance sometimes is a pain in the ass:

  - Performance issues
  - Hard to mantain
  - ***M  e  t  a  t  a  b  l  e  s***

Well, it can depend on how is implemented... But still is a pain in the ass.

So... *"How I can **implement** functions in my class?"*. Well, that's quite simple:

```lua
local Class = require("Self")()

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

## The `Class` function

This is the main function to get OOP done with Self, the table that u pass to this function is used like a "template" or "blueprint". By example:

```lua
local Class = require("Self")()
local Person = Class { name = '' }

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

## "Immutability"

Self objects (class instances) are, in a sense, inmutable. As you saw above, you can only write existing properties in an object. For methods is a bit different: you can overwrite methods from an object. By example (following the above person example):

```lua
-- ...

-- This will throw an error
me.greet = 29
```

This is the reason why (at the moment) there's no way to support custom `__index` and `__newindex` metamethods, because this behavior is handled using these metamethods.

[commit]: https://github.com/Miqueas/Self/commit/575093ae9f53fe67c930543891cd117410235993