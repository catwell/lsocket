### add your documentation files here

DOCFILES=README README_ARESOLVER CHANGELOG

### no user servicable parts below

ROCK=$(shell basename src/*.rockspec .rockspec)

all:
	@echo targets are pack and html
	@echo to build the module, enter src and make there.

# make html documentation from text (markdown) documentation

html: $(DOCFILES:%=html/%.html)

html/%.html: src/doc/% html/header html/footer
	sed -e"s/%NAME%/`basename $<`/" < html/header > $@
	lunamark -X notes,definition_lists,pandoc_title_blocks $< >> $@
	sed -e"s/%NAME%/`basename $<`/" < html/footer >> $@

# build archive for luarocks

pack: doc
	cd src && make clean
	cd src && luarocks lint $(ROCK).rockspec
	mkdir $(ROCK)
	cp -r src/* $(ROCK)
	tar czf $(ROCK).tar.gz $(ROCK)
	rm -rf $(ROCK)
