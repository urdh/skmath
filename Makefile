TEXMFHOME ?= $(shell kpsewhich -var-value TEXMFHOME)
.PHONY: all clean distclean install dist
all: skmath.pdf
clean:
	rm -f *.sty
distclean: clean

%.pdf: %.tex %.sty
	makeglossaries $*
	pdflatex -shell-escape $<
	makeglossaries $*
	pdflatex -shell-escape $<

%.sty: %.tex
	pdflatex $<

install: all
	install -m 0644 skmath.sty $(TEXMFHOME)/tex/latex/skmath/skmath.sty
	install -m 0644 skmath.pdf $(TEXMFHOME)/doc/latex/skmath/skmath.pdf
	install -m 0644 skmath.tex $(TEXMFHOME)/source/latex/skmath/skmath.tex
	install -m 0644 README $(TEXMFHOME)/doc/latex/skmath/README
	-mktexlsr

skmath.tds.zip: skmath.tex skmath.pdf skmath.sty
	mkdir -p skmath/{tex,doc,source}/latex/skmath
	cp skmath.sty skmath/tex/latex/skmath/skmath.sty
	cp skmath.pdf skmath/doc/latex/skmath/skmath.pdf
	cp skmath.tex skmath/source/latex/skmath/skmath.tex
	cp README skmath/doc/latex/skmath/README
	cd skmath && zip -r ../skmath.tds.zip *
	rm -rf skmath

skmath.tar.gz: skmath.tds.zip skmath.tex skmath.pdf
	mkdir -p skmath
	cp skmath.tex skmath/skmath.tex
	cp skmath.pdf skmath/skmath.pdf
	cp README skmath/README
	cp Makefile skmath/Makefile
	tar -czf $@ skmath skmath.tds.zip
	rm -rf skmath

dist: skmath.tar.gz
