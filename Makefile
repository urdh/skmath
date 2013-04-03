TEXMFHOME ?= $(shell kpsewhich -var-value TEXMFHOME)
.PHONY: all clean distclean install
all: skmath.pdf
clean:
	rm -f *.sty
distclean: clean

%.pdf: %.tex
	pdflatex $<
	makeglossaries $*
	pdflatex -shell-escape $<
	makeglossaries $*
	pdflatex -shell-escape $<

%.sty: %.pdf

install: all
	install -m 0644 skmath.sty $(TEXMFHOME)/tex/latex/skmath/skmath.sty
	install -m 0644 skmath.pdf $(TEXMFHOME)/doc/latex/skmath/skmath.pdf
	install -m 0644 skmath.tex $(TEXMFHOME)/source/latex/skmath/skmath.tex
	install -m 0644 README $(TEXMFHOME)/doc/latex/skmath/README
	-mktexlsr
