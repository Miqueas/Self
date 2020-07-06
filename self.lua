------------------------
-- Easy classes for Lua!
-- A Lua library for handle classes & OOP
-- Based on luaclass: https://github.com/benglard/luaclass
-- @author Miqueas Martinez
-- @license MIT
-- @mod ecls

local metamethods = {
  '__index', '__tostring', '__len', '__unm',
  '__add', '__sub', '__mul', '__div', '__mod',
  '__pow', '__concat', '__eq', '__lt', '__le',
  '__call', '__gc', '__newindex', '__mode'
}

local function clsRawGet(t, key)
  if t == nil then
    return nil
  else
    local  val = t[key]
    if val == nil then
      return clsRawGet(t._parent, key)
    else
      return val
    end
  end
end

local function construct_metatable(t)
  local meta = {}

  for k, m in pairs(metamethods) do
    meta[m] = clsRawGet(t, m)
  end

  return meta
end

--- "New keyword"
-- Creates a new instance of the given name class and returns it
-- @string name Class name
-- @arg[opt] ... Arguments to be passed to the class (vararg)
-- @treturn name A new class instance
function New(name, ...)
  local cls = assert(_G[name], ("Class '%s' not exists"):format(name))
  return cls(...)
end

--- "Class keyword"
-- Creates a class using the given table as definition
-- @string name Class name
-- @tparam table def Class body definition
-- @tparam[opt] Class parent A parent class
function Class(name, def, parent)
  local subcls = parent ~= nil
  local parent = parent or {}
  local def = def or {}

  def.init = def.init or parent.init or function(self) end

  def.set = def.set or function (self, k, v)
    assert(self[k], ("Key '%s' not exists."):format(k))
    assert(type(self[k]) ~= "function", ("Key '%s' is a function/method."):format(k))
    self[k] = v
  end

  def.get = def.get or function (self, k)
    assert(self[k], ("Key '%s' not exists."):format(k))
    assert(type(self[k]) ~= "function", ("Key '%s' is a function/method."):format(k))
    return self[k]
  end

  local def__call = {
    __call = function(cls, ...)
      local ref = {}

      if subcls then
        for k, v in pairs(parent) do
          if k ~= ("init" or "set" or "get") then
            ref[k] = v
          end
        end
      end

      for k, v in pairs(cls) do
        ref[k] = v
      end

      setmetatable(ref, construct_metatable(ref))
      def.init(ref, ...)
      return ref
    end
  }

  setmetatable(def, def__call)

  rawset(_G, name, def)
end