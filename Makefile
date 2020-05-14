version=5.3
prefix=/usr/share/lua/$(version)
module=ecls

install:
	@echo "Installing in: $(prefix)/$(module)"
	cp -vR $(module) $(prefix)/$(module)

doc:
	ldoc -c doc.ld .