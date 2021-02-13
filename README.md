[![License][LicenseBadge]][licenseURL]

¡Hey! ¿Buscas una versión en Español? ¡Revisa [aquí](README_es.md)!

# Self

A small and simple library for OOP in Lua.

### Basic usage

Here's a simple example:

```lua
local Class = require("Self") -- We load the library
local Point = Class("Point") -- Create our class

function Point:new(x, y) -- Define the constructor
  self.x = x or 0
  self.y = y or 0
end

local p = Point(10, 40) -- Then 'p' is an instance of the class 'Point'
```

Read the docs [here](Docs.md)

[LicenseBadge]: https://img.shields.io/badge/License-Zlib-brightgreen?style=for-the-badge
[LicenseURL]: https://opensource.org/licenses/Zlib
