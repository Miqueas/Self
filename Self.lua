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
    return error(msg, 0)
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

-- Parent class for all classes
--- @class Object
local Object = {}
Object.new = Object.__call

--- Creates a class
--- @param def table
--- @return table
function Class(def)
  check_arg(1, def, "table")

  local class = setmt(def, Object)
  class.__index = class

  return class
end

function Object.implements(class, ...)
  check_arg(1, class, "table")

  for iface_index, iface in ipairs({ ... }) do
    check_arg(iface_index, iface, "table")

    for name, func in pairs(iface) do
      if not get(class, name) then
        set(class, name, func)
      end
    end
  end
end

function Object.__call(class, ...)
  check_arg(1, class, "table")

  local o = setmt({}, class)
  o:new(...)

  return o
end

-- Getter
-- * May need a revision
function Object.__index(class, key)
  local cval = get(class, key)

  if cval then
    return cval
  end

  return get(Object, key)
end

-- TODO: write an actually good setter

-- TODO: document about this returned function
return function (G_New, G_Object)
  opt_arg(1, G_New, "boolean")
  opt_arg(2, G_Object, "boolean")

  if G_New then
    if not get(_G, "New") then
      _G.New = Object.new
    else
      print("\n[WARN] Self.lua: `_G` already has field named `New`.\n")
    end
  end

  if G_Object then
    return Class, Object
  end

  return Class
end