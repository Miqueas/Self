--[[
  Author: Miqueas Martinez (miqueas2020@yahoo.com)
  Date: 2020/04/30
  License: Zlib (see it in the repository)
  Git Repository: https://github.com/Miqueas/Self
]]

local unp   = unpack or table.unpack
local getmt = getmetatable
local setmt = setmetatable
local get   = rawget
local set   = rawset

-- Parent class for all classes
--- @class Object
local Object = {}
local Object_mt = {}
Object_mt.__index = Object

--- A simple custom version of `assert()`
--- @param exp any Expression to evaluate
--- @param msg string Error message to print
--- @vararg any Additional arguments to format for `msg`
--- @return any
local function err(exp, msg, ...)
  local msg = msg:format(...)

  if not (exp) then
    return error(msg, 0)
  end

  return exp
end

--- Creates a class
--- @vararg table|nil
--- @return table
function Class(def)
  local class = setmt(def or {}, Object_mt)
  --class.__index = class

  return class
end

-- TODO: e
function Object:implements(iface_list)
  err(
    type(iface_list) == "table",
    "Bad argument for implements(), `table` expected, got `%s`",
    type(iface_list)
  )

  if #iface_list > 0 then
    for index, iface in ipairs(iface_list) do
      err(
        type(iface) == "table",
        "Bad type in `iface_list` at index #%d, `table` expected, got `%s`",
        index, type(iface)
      )

      for name, func in pairs(iface) do
        if type(func) == "function" and not get(self, name) then
          set(self, name, func)
        end
      end
    end
  end
end

function Object_mt.__call(class, ...)
  err(class ~= Object, "Trying to instantiate base class 'Object'")
  err(class.__ctor, "This class don't have a constructor", tostring(class))

  local o = setmt({}, class)
  o:__ctor(...)
  return o
end

function Object_mt.__index(self, key, val)
  if get(self, key) then
    return get(self, key)
  elseif get(Object, key) then
    return get(Object, key)
  else
    return err(nil, "This class don't have a field named '%s'", key)
  end
end

-- Object.new = Object_mt.__call
-- _G.new     = Object_mt.__call

return Class