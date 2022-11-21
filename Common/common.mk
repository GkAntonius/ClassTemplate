# =========================================================================== #
# == Platform-specific variables and options ==
# =========================================================================== #

# Command to open a pdf
openpdf = open  # MacOS
#openpdf = evince  # Linux


# LaTeX engine
compiler = pdflatex
flags = -shell-escape -halt-on-error -output-directory out
bibengine = biber

# Include local files and document classes in TEX environment variable.
texcommon = $(topdir)/Common/
texclasses = $(topdir)/Common/texmf/tex/latex/uqtr/
CURRENT := $(TEXINPUTS)
export TEXINPUTS="..//:$(texclasses):$(texcommon):$(CURRENT):"

# =========================================================================== #
# == Rules ==
# =========================================================================== #

main = main
references = main.bib

corrigename = $(finalname)-corrige
addendumname = $(finalname)-addendum

all: final

bib: out/main.bbl out/main.pdf

out/$(main).pdf: always


# Create directories
dirs:
	mkdir -p out img pdf


# Open output
open: 
	$(openpdf) out/$(main).pdf

out/%.pdf: %.tex dirs
	$(compiler) $(flags) $<;


# Bibliography
out/%.bbl: %.tex $(references)
	$(compiler) $(flags) $<;\
	mkdir -p out;\
	cd out;\
	ln -nfs ../$(references) $*.bib;\
	$(bibengine) $*;\
	cd ..;\
	$(compiler) $(flags) $<


final: out/$(main).pdf
	@echo "cp $< pdf/$(finalname).pdf"
	@cp $< pdf/$(finalname).pdf

corrige: out/$(main).pdf
	@echo "cp $< pdf/$(corrigename).pdf"
	@cp $< pdf/$(corrigename).pdf

addendum: out/$(main).pdf
	@echo "cp $< pdf/$(addendumname).pdf"
	@cp $< pdf/$(addendumname).pdf

always: 
	True

clean:
	rm -f out/*
	rm -rf _minted-main
	rm -rf out/_minted-main

veryclean: clean
	rm -f pdf/*

recursive: final

help:
	cat Makefile
