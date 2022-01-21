--[[
  Author: Miqueas Martinez (miqueas2020@yahoo.com)
  Date: 2020/04/30
  Git Repository: https://github.com/Miqueas/Self

  zlib License

  Copyright (c) 2020 - 2022 Miqueas Martinez

  This software is provided 'as-is', without any express or implied
  warranty. In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

    1. The origin of this software must not be misrepresented; you must not
      claim that you wrote the original software. If you use this software
      in a product, an acknowledgment in the product documentation would be
      appreciated but is not required.

    2. Altered source versions must be plainly marked as such, and must not be
      misrepresented as being the original software.

    3. This notice may not be removed or altered from any source
      distribution.
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
--- @return Expr
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
--- @return nil
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
--- @return nil
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
--- @param def table Class "template"
--- @return table
function Class(def)
  check_arg(1, def, "table")

  local class = setmt(def, Object)

  return class
end

--- Return `true` if `instance` is type of `class`,
--- otherwise returns false. If `class` is `nil`,
--- then returns "Object".
--- @param instance table The object
--- @param class table The class
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
--- @param class table The class where implement functions
--- @param ... table Tables/classes with functions to import from
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

--- Global constructor
--- @param class table The class to use to create the object
--- @param ... any Additional arguments to pass to the class constructor
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
--- @param class table The object
--- @param key string The key
--- @return any
function Object.__index(class, key)
  return get(class, key) or get(Object, key)
end

--- Setter
--- @param class table The object
--- @param key string The key
--- @param val any The value
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
--- @return function, Object|nil
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