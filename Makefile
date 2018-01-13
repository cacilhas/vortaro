ELMC= elm make


#-------------------------------------------------------------------------------
all: docs/vortaro.html

docs/vortaro.html: Main.elm
	$(ELMC) $< --output=$@
