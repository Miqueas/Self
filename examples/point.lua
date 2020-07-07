local Class = require("self")

Class("Point", nil, {
  new = function (self, x, y)
    self.x = x or 0
    self.y = y or 0
  end,

  setX = function (self, x)
    assert(x, "No value for X")
    self.x = x
  end,

  setY = function (self, y)
    assert(y, "No value for Y")
    self.y = y
  end
}, true)

Class("Rect", Point, {
  new = function (self, x, y, w, h)
    Point.new(self, x, y)
    self.w = w or 0
    self.h = h or 0
  end,

  setW = function (self, w)
    assert(w, "No value for width")
    self.w = w
  end,

  setH = function (self, h)
    assert(h, "No value for height")
    self.h = h
  end
}, true)

Class("Rombo", Rect, {
  new = function (self, x, y, w, h, r)
    Rect.new(self, x, y, w, h)
    self.r = r or 180
  end,

  setR = function (self, r)
    assert(r, "No value for fotation")
    self.r = r
  end
}, true)

local p  = Point(10, 20)
local re = Rect(p.x, p.y, 400, 400)
local ro = Rombo(re.x, re.y, re.w, re.h)

print(p:dump())
print(re:dump())
print(ro:dump())