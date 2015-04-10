### add your documentation files here

DOCFILES=src/doc/README

### no user servicable parts below

ROCK=$(shell basename src/*.rockspec .rockspec)

all:
	@echo targets are pack and doc
	@echo to build the module, enter src and make there.

# make text documentation from html documentation

doc: $(DOCFILES)

src/doc/%:	html/%.html
	lynx -dump $< > $@

# build archive for luarocks

pack: doc
	cd src && make clean
	cd src && luarocks lint $(ROCK).rockspec
	mkdir $(ROCK)
	cp -r src/* $(ROCK)
	tar czf $(ROCK).tar.gz $(ROCK)
	rm -rf $(ROCK)
