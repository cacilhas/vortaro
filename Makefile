INDEX= index.pug
PUG_STRING= const fs = require("fs"); const pug = require("pug"); \
            const filename = "$(INDEX)"; \
			const template = fs.readFileSync(filename); \
			console.log(pug.compile(template, {filename})({}));

ELMC= elm make
PUG= node -e '$(PUG_STRING)'
MD= mkdir -p
RM= rm -rf
CP= cp -f


#-------------------------------------------------------------------------------
.PHONY: clean

all: docs/vortaro.html docs/index.html docs/vortaro.text

clean:
	$(RM) docs


docs/vortaro.html: Main.elm docs
	$(ELMC) $< --output=$@

docs/index.html: $(INDEX) docs
	$(PUG) > $@

docs/vortaro.text: vortaro.text
	$(CP) $< $@

docs:
	$(MD) $@
