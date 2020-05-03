require("../ecls")

-- 'set' & 'get' methods test
Class("Foo", {
  k = "key",
  v = "val"
})

local f = Foo()
local v = f:get('k')
f:set('v', "some value")
print(v)
print(f:get('v'))