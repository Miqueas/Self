require("../ecls")

-- Car full example for README.md
Class("Car", {
  model = 'none',
  maker = 'none',

  __init__ = function (self, model, maker)
    self.model = model or "Mustang"
    self.maker = maker or "Ford"
  end,

  on = function (self)
    print(("The %s is ready for run!"):format(self.model))
  end,

  off = function (self)
    print(("Time to sleep..."))
  end,

  run = function (self)
    print("Speeddd!!!")
  end
})

local mustang = Car()
mustang:on()
mustang:run()
mustang:off()

Class("Camaro", {
  model = "Camaro",
  maker = "Chevrolet",
  status = "off",

  on = function (self)
    self.status = "on"
    print(("The %s is ready for run!"):format(self.model))
  end,

  off = function (self)
    self.status = "off"
    print(("Time to sleep..."))
  end,

  run = function (self)
    if self.status == "off" then
      error("The Camaro is off!")
    else
      print("Oh boi, this Camaro is very fassssst!")
    end
  end
}, Car)

local camaro = Camaro()
camaro:run() -- Esto retornará un error