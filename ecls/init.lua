local metamethods = {
  '__index', '__tostring', '__len', '__unm',
  '__add', '__sub', '__mul', '__div', '__mod',
  '__pow', '__concat', '__eq', '__lt', '__le',
  '__call', '__gc', '__newindex', '__mode'
}

local function rawGet(t, key)
  if t == nil then
    return nil
  else
    local  val = t[key]
    if val == nil then
      return rawGet(t._parent, key)
    else
      return val
    end
  end
end

local function newMetatable(t)
  local meta = {}

  for k, m in pairs(metamethods) do
    meta[m] = rawGet(t, m)
  end

  return meta
end

function Class(name, def, parent)
  local subcls = parent ~= nil
  local parent = parent or {}
  local def = def or {}

  def.__init__ = def.__init__ or parent.__init__ or function (self) end

  setmetatable(def, {
    __call = function(cls, ...)
      local ref = {}

      if subcls then
        for k, v in pairs(parent) do
          if k ~= ("__init__" or "set" or "get") then
            ref[k] = v
          end
        end
      end

      for k, v in pairs(cls) do
        ref[k] = v
      end

      setmetatable(ref, newMetatable(ref))
      def.__init__(ref, ...)
      return ref
    end
  })

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

  rawset(_G, name, def)
end

function yield(...)
  local arg = {...}
  if #arg == 1 then coroutine.yield(...)
  else coroutine.yield(arg)
  end
end

function Generator(f)
  local cor = coroutine.create(f)
  return function(...)
    local status, val = coroutine.resume(cor, ...)
    return val
  end
end