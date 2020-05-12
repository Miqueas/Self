require("ecls")

Class("Point", {
  x = 0,
  y = 0,

  init = function (self, x, y)
    self.x = x
    self.y = y
  end
})

-- Prueba para la función "New"
local p = New("Point", 20, 10)
print(("X: %s, Y: %s"):format(p.x, p.y))