# Documentation

Self is intended to be simple, fast and easy to use. The difference between Self and others OOP libraries is mainly in the design/features:

  - All clases inherits directly from `Object`
  - Inheritance isn't supported ***at all*** (I'll try to explain this later)
  - At the moment, custom `__index` and `__newindex` metamethods aren't supported
  - There's an optional global constructor function called `New` (offering an C#/Java-like syntax)
  - Tries to generate clean tables (no `_thing` or `__thing` crap)

## About inheritance

With the recent changes (since this [commit][commit]) in Self, I have removed the support for inheritance. Instead, I'm trying to use a composition-like focus, so now inheritance is basically the same as implementing a set of functions into a class, keeping all the classes/objects with just one parent: `Object`. I made that because supporting inheritance sometimes is a pain in the ass:

  - Performance issues
  - Hard to mantain
  - ***M  e  t  a  t  a  b  l  e  s***

Well, it can depend on how is implemented... But still is a pain in the ass.

# API

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

[commit]: https://github.com/Miqueas/Self/commit/575093ae9f53fe67c930543891cd117410235993