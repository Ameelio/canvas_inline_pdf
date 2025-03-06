
.PHONY: all clean

SRC := $(wildcard src/*.mts)
OBJECTS := $(patsubst src/%.mts,build/%.mjs,$(SRC))
BUNDLES := dist/index.js dist/index.html dist/worker.min.mjs dist/dummy.pdf

all: $(BUNDLES)

dist/%.js: $(SRC)
	scripts/build.mjs

dist/%.html: static/%.html
	cp -f $(<) $(@)

dist/worker.min.mjs: node_modules/pdfjs-dist/build/pdf.worker.min.mjs
	cp -f $(<) $(@)

dist/dummy.pdf:
	curl -o dist/dummy.pdf "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"

clean:
	rm -f $(OBJECTS) $(BUNDLES) dist/index.js.map
