--[[
  Author: Miqueas Martinez (miqueas2020@yahoo.com)
  Date: 2020/04/30
  License: MIT (see it in the repository)
  Git Repository: https://github.com/M1que4s/Self
]]

local Class   = require("Self")
local unp     = unpack or table.unpack
local Stack   = Class {
  S       = { main = {} }, -- Store all stacks
  current = "main",        -- Current workspace name
  stacks  = { "main" }     -- Control list of all registered stacks
}

--[[ new: (Constructor) creates a new instance of this Stack class
  Arguments:
    (string) ... One or more names for stacks
]]
function Stack:__ctor(...)
  local args = {...}

  if #args > 0 then
    for _, v in ipairs(args) do
      if type(v) == "string" then
        self.S[v] = {}
        table.insert(self.stacks, v)
      end
    end
  end
end

--[[ push: append one or more things to an stack
  Arguments:
    (any) ... One or more of A N Y T H I N G
]]
function Stack:push(...)
  local args = {...}

  if #args > 0 then
    for _, v in ipairs(args) do
      table.insert(self.S[self.current], v)
    end
  end
end

--[[ pop: removes anything from the given position of the stack. If no argument, then removes the last value added
  Arguments (optional):
    (number) pos The index of the value that you want to remove
]]
function Stack:pop(pos)
  table.remove(self.S[self.current], pos)
end

-- get: like 'pop', but return a value instead of remove
function Stack:get(pos)
  local last = self.S[self.current][#self.S[self.current]]

  if pos then
    return self.S[self.current][pos]
  end

  return last
end

--[[ switch: switch between workspaces names
  Arguments:
    (string) name Name of the workspace that you want to switch
]]
function Stack:switch(name)
  assert(self.S[name], ("Stack '%s' not exists"):format(name))
  self.current = name
end

-- name: returns the name of the current workspace
function Stack:name() return self.current end
-- len: returns the count of items in the current workspace
function Stack:len() return #self.S[self.current] end
-- unp: wrapper for "unpack" or "table.unpack"
function Stack:unpack() return unp(self.S[self.current]) end

--[[ create: creates (and adds) a new stack in the current instance
  Arguments:
    (string) name Name of the stack
]]
function Stack:create(name)
  self.S[name] = {}
  table.insert(self.stacks, name)
end

--[[ clear: removes all values on a stack and leaves it empty. If no stack name given, then use the current stack
]]
function Stack:clear(name)
  local name = name or self.current
  assert(self.S[name], ("Stack '%s' not exists"):format(name))
  self.S[name] = {}
end

-- list: returns the names of all stacks
function Stack:list() return unp(self.stacks) end
-- index: returns the index in the current stack of the given value
function Stack:index(val)
  for i, v in ipairs(self.S[self.current]) do
    if v == val then
      return i
    end
  end
end

-- destroy: set to 'nil' (destroy) an stack using the given stack name or the current stack if isn't 'main'
function Stack:destroy(name)
  local name = name or self.current
  assert(name ~= "main", "'main' stack can't be destroyed")
  for i, v in ipairs(self.stacks) do
    if v == name then
      table.remove(self.stacks, i)
    end
  end
  self.S[name] = nil
end

return Stack