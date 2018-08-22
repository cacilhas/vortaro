INDEX= index.pug
README= README.md
PUG_STRING= const fs = require("fs"); \
	const pug = require("pug"); \
	const filename = "$(INDEX)"; \
	const template = fs.readFileSync(filename); \
	console.log(pug.compile(template, {filename})({}));

MD_STRING= const fs = require("fs"); \
	const {markdown} = require("markdown"); \
	const filename = "$(README)"; \
	const template = fs.readFileSync(filename); \
	console.log(markdown.toHTML(template.toString()));

ELMC= elm make
PUG= node -e '$(PUG_STRING)'
MDC= node -e '$(MD_STRING)'
MD= mkdir -p
RM= rm -rf
CP= cp -f


#-------------------------------------------------------------------------------
.PHONY: clean

all: docs/vortaro.html docs/index.html docs/vortaro.text \
	docs/css/vortaro.css docs/css/ie10-viewport-bug-workaround.css

clean:
	$(RM) docs about.html

about.html: $(README)
	$(MDC) > $@

docs/vortaro.html: Main.elm docs
	$(ELMC) $< --output=$@

docs/index.html: $(INDEX) docs about.html
	$(PUG) > $@

docs/vortaro.text: vortaro.text docs
	$(CP) $< $@

docs/css/%: css/% docs/css
	$(CP) $< $@

docs/css: docs
	$(MD) $@

docs:
	$(MD) $@
