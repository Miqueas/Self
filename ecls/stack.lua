require("ecls")

local unp = table.unpack or unpack

Class("Stack", {
  main = {},
  current = "main",
  stacks = { "main" },

  __init__ = function (self, ...)
    local args = {...}

    if #args > 0 then
      for _, v in ipairs(args) do
        if type(v) == "string" then
          self[v] = {}
          table.insert(self.stacks, v)
        end
      end
    end

    return self
  end,

  push = function (self, ...)
    local args = {...}
    local current = self[self.current]

    if #args > 0 then
      for _, v in ipairs(args) do
        table.insert(current, v)
      end
    end
  end,

  pop = function (self, pos)
    local current = self[self.current]
    table.remove(current, pos)
  end,

  get = function (self, pos)
    local current = self[self.current]
    local last = #current
    return current[pos] or current[last]
  end,

  switch = function (self, name)
    assert(self[name], ("Stack '%s' not exists"):format(name))
    self.current = name
  end,

  name = function (self) return self.current end,
  len = function (self) return #self[self.current] end,
  unpack = function (self) return unp(self[self.current]) end,

  new = function (self, name)
    self[name] = {}
    table.insert(self.stacks, name)
  end,

  index = function (self, val)
  end,

  clear = function (self, name)
  end,

  destroy = function (self, name)
  end,

  list = function (self) return unp(self.stacks) end,
  __len = function (self) return self:len() end
})