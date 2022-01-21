--[[
  Author: Miqueas Martinez (miqueas2020@yahoo.com)
  Date: 2020/04/30
  Git repository: https://github.com/Miqueas/Self
]]

local Class = require("Self")()
local unp   = unpack or table.unpack
local Stack = Class {
  reg = { main = {} },
  current = "main",
  stacks = { "main" }
}

function Stack:new(...)
  local args = {...}

  if #args > 0 then
    for _, v in ipairs(args) do
      if type(v) == "string" then
        self.reg[v] = {}
        table.insert(self.stacks, v)
      end
    end
  end
end

function Stack:push(...)
  local args = {...}

  if #args > 0 then
    for _, v in ipairs(args) do
      table.insert(self.reg[self.current], v)
    end
  end
end

function Stack:pop(pos)
  table.remove(self.reg[self.current], pos)
end

function Stack:get(pos)
  local last = self.reg[self.current][#self.reg[self.current]]

  if pos then
    return self.reg[self.current][pos]
  end

  return last
end

function Stack:switch(name)
  assert(self.reg[name], ("Stack '%s' not exists"):format(name))
  self.current = name
end

function Stack:name() return self.current end
function Stack:len() return #self.reg[self.current] end
function Stack:unpack() return unp(self.reg[self.current]) end

function Stack:create(name)
  self.reg[name] = {}
  table.insert(self.stacks, name)
end

function Stack:clear(name)
  local name = name or self.current
  assert(self.reg[name], ("Stack '%s' not exists"):format(name))
  self.reg[name] = {}
end

function Stack:list() return unp(self.stacks) end

function Stack:index(val)
  for i, v in ipairs(self.reg[self.current]) do
    if v == val then
      return i
    end
  end
end

function Stack:destroy(name)
  local name = name or self.current
  assert(self.reg[name], ("Stack '%s' not exists"):format(name))
  assert(name ~= "main", "'main' stack can't be destroyed")
  for i, v in ipairs(self.stacks) do
    if v == name then
      table.remove(self.stacks, i)
    end
  end
  self.reg[name] = nil
end

return Stack