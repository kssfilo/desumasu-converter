.SUFFIXES:

APPNAME=desumasu-converter
VERSION=0.1.1

#=

COMMANDS=help pack test clean

#=

DESTDIR=dist
COFFEES=$(wildcard *.coffee)
TARGETNAMES=package.json LICENSE $(patsubst %.coffee,%.js,$(COFFEES)) 
TARGETS=$(patsubst %,$(DESTDIR)/%,$(TARGETNAMES))
ALL=$(TARGETS) $(DESTDIR)/README.md
SDK=node_modules/.gitignore
TOOLS=node_modules/.bin

#=

.PHONY:$(COMMANDS)

test:$(ALL) test.bats
	./test.bats

pack:$(ALL)|$(DESTDIR)

clean:
	-rm -r $(DESTDIR) node_modules

help:
	@echo "Targets:$(COMMANDS)"

#=

$(DESTDIR):
	mkdir -p $@

$(DESTDIR)/README.md:README.md $(TARGETS) $(SDK)
	cat README.md|$(TOOLS)/partpipe >$@

$(DESTDIR)/package.json:package.json $(SDK)|$(DESTDIR)
	cat $<|$(TOOLS)/partpipe VERKEY@version VERSION@$(VERSION) >$@

$(DESTDIR)/%.js:%.coffee $(SDK) |$(DESTDIR)
ifndef NC
	$(TOOLS)/coffee-jshint -o node $< 
endif
	head -n1 $<|grep '^#!'|sed 's/coffee/node/'  >$@ 
	cat $<|$(TOOLS)/coffee -bcs >> $@
	chmod +x $@

$(DESTDIR)/%:%|$(DESTDIR)
	cp $< $@

$(SDK):package.json
	npm install
	@touch $@
