[![License][LicenseBadge]][licenseURL]

# Self

A small and simple library for OOP in Lua.

## Basic usage

Here's a simple example:

```lua
local class = require("Self")
local Point = class {
  x = 0,
  y = 0
}

function Point:new(x, y)
  self.x = x
  self.y = y
end

local p = Point(10, 40)
```

Read the docs [here](Docs.md)

[LicenseBadge]: https://img.shields.io/badge/License-Zlib-brightgreen?style=flat
[LicenseURL]: https://opensource.org/licenses/Zlib
