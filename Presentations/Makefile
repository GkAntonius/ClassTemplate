
all: force
	mkdir -p All
	cp -f [1-9]-*/pdf/* All/ 2>/dev/null || :
	cp -f 0[1-9]-*/pdf/* All/ 2>/dev/null || :
	cp -f 1?-*/pdf/* All/ 2>/dev/null || :

force:
	@True
