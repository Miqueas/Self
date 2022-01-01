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

--[[ Private stuff ]]

--- A simple custom version of `assert()` with built-in
--- `string.format()` support
--- @generic Expr
--- @param exp Expr Expression to evaluate
--- @param msg string Error message to print
--- @vararg any Additional arguments to format for `msg`
--- @return any
local function err(exp, msg, ...)
  local msg = msg:format(...)

  if not (exp) then
    return error(msg)
  end

  return exp
end

--- Argument type checking function
--- @generic Any
--- @generic Type
--- @param argn number The argument position in function
--- @param arg_ Any The argument to check
--- @param expected Type The type expected (`string`)
local function check_arg(argn, arg_, expected)
  local argt = type(arg_)
  local msg = "Bad argument #%d, `%s` expected, got `%s`."

  if argt ~= expected then
    error(msg:format(argn, expected, argt))
  end
end

--- Same as `check_arg()`, except that this don't throw
--- and error if the argument is `nil`
--- @generic Any
--- @generic Type
--- @param argn number The argument position in function
--- @param arg_ Any The argument to check
--- @param expected Type The type expected (`string`)
local function opt_arg(argn, arg_, expected)
  local argt = type(arg_)
  local msg = "Bad argument #%d, `%s` or `nil` expected, got `%s`."

  if argt ~= expected and argt ~= "nil" then
    error(msg:format(argn, expected, argt))
  end
end

--[[ Public stuff ]]

--- Parent class for all classes
--- @class Object
local Object = {}

--- Creates a class
--- @param def table
--- @return table
function Class(def)
  check_arg(1, def, "table")

  local class = setmt(def, Object)

  return class
end

--- Return `true` if `instance` is type of `class`,
--- otherwise returns false
--- @param instance table
--- @param class table
--- @return table|string
function Object.is(instance, class)
  check_arg(1, instance, "table")
  opt_arg(2, class, "table")

  local mt = getmt(instance)
  
  if not class then
    return "Object"
  end

  return mt == class or getmt(mt) == Object
end

--- Implements all functions from one or more classes/tables given.
--- Can't use this from an instance.
--- @param class table
--- @vararg table Tables/classes with functions to import from
--- @return nil
function Object.implements(class, ...)
  check_arg(1, class, "table")

  -- Prevent using this method from an instance
  err(
    getmt(class) == Object,
    "Trying to call 'implements' method from an instance"
  )

  for iface_index, iface in ipairs({ ... }) do
    check_arg(iface_index, iface, "table")

    for name, func in pairs(iface) do
      if not get(class, name) then
        set(class, name, func)
      end
    end
  end
end

--- Handles how tables are "called"
--- @param class table
--- @vararg table Tables/classes with functions to import from
--- @return table
function Object.__call(class, ...)
  check_arg(1, class, "table")

  -- At the moment, these two meta-fields aren't writables
  set(class, "__index", class)
  set(class, "__newindex", Object.__newindex)

  local o = setmt({}, class)
  o:new(...)

  return o
end

--- Getter
--- @param class table
--- @param key string
--- @return any
function Object.__index(class, key)
  return get(class, key) or get(Object, key)
end

--- Setter
--- @param class table
--- @param key string
--- @param val any
--- @return nil
function Object.__newindex(class, key, val)
  local mt = getmt(class)
  local _val = get(class, key) or get(mt, key)

  if mt == Object then
    -- From a class
    set(class, key, val)
  else
    -- From an instance
    err(_val, "Field '%s' doesn't exists.", key)
    err(type(_val) ~= "function", "Trying to overwrite method '%s'.", key)
    set(class, key, val)
  end
end

Object.new = Object.__call

--- Handles what will be returned when "require()" this library.
--- See the documentation for more details.
--- @param g_constructor boolean Enable/disable global constructor
--- @param g_object boolean Enable/disable global `Object`
return function (g_constructor, g_object)
  opt_arg(1, g_constructor, "boolean")
  opt_arg(2, g_object, "boolean")

  if g_constructor then
    if not _G.New then
      _G.New = Object.new
    end
  end

  if g_object then
    return Class, Object
  end

  return Class
end