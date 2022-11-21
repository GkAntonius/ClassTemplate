
all: force
	mkdir -p All
	cp -f [1-9]-*/pdf/* All/ 2>/dev/null || :
	cp -f 0[1-9]-*/pdf/* All/ 2>/dev/null || :
	cp -f 1?-*/pdf/* All/ 2>/dev/null || :

example:
	mkdir -p 01-Example && rsync -avhF 00-Template/ 01-Example

force:
	@True

clean:
	rm -f All/*
	rm -rf 01-Example
