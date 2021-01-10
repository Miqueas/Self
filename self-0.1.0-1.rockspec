package = "Self"
-- SemVer: 0.1.0
-- Revisión: 1
version = "0.1.0-1"
source = {
  url = "git://github.com/M1que4s/Self",
  tag = "v0.1.0"
}

description = {
  summary = "A small and lightweight OOP library",
  detailed = "Self provides a simple API that allows to use/implement some basic OOP features.",
  homepage = "https://github.com/M1que4s/Self",
  license = "MIT"
}

dependencies = {
  "lua >= 5.1, < 5.4"
}

build = {
  type = "builtin",
  modules = {
    ["Self"] = "Self.lua",
    ["Self.Stack"] = "Stack.lua"
  }
}
