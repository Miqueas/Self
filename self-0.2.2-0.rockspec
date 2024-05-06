package = "Self"
-- SemVer: 0.2.2
-- Revision: 0
version = "0.2.2-0"
source = {
  url = "git://github.com/Miqueas/Self",
  tag = "v0.2.2"
}

description = {
  summary = "A small and lightweight OOP library",
  detailed = "Self provides a simple API that allows to use/implement some basic OOP features.",
  homepage = "https://github.com/Miqueas/Self",
  license = "MIT"
}

dependencies = {
  "lua >= 5.1, < 5.5"
}

build = {
  type = "builtin",
  modules = {
    ["Self"] = "Self.lua",
    ["Self.Stack"] = "Stack.lua"
  }
}
