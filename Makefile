TEXMFHOME ?= $(shell kpsewhich -var-value TEXMFHOME)
.PHONY: all clean distclean install dist test clean-test
all: skmath.tex skmath.pdf skmath.sty README
clean: clean-test
	rm -f *.gl? *.id? *.aux *.glsdefs # problematic files
#	rm -f *.bbl *.bcf *.bib *.blg *.xdy # biblatex
	rm -f *.fls *.log *.out *.run.xml *.toc # junk
distclean: clean
	rm -f *.cls *.sty *.clo *.tar.gz *.tds.zip README
	git reset --hard

%.pdf: %.tex %.sty
	makeglossaries $*
	pdflatex -interaction=nonstopmode -halt-on-error -shell-escape $<
	makeglossaries $*
	pdflatex -interaction=nonstopmode -halt-on-error -shell-escape $<

%.sty: %.tex
	pdflatex -interaction=nonstopmode -halt-on-error $<

README: README.md
	sed -e '1,4d;$$d' $< > $@

install: all
	install -m 0644 skmath.sty $(TEXMFHOME)/tex/latex/skmath/skmath.sty
	install -m 0644 skmath.pdf $(TEXMFHOME)/doc/latex/skmath/skmath.pdf
	install -m 0644 skmath.tex $(TEXMFHOME)/source/latex/skmath/skmath.tex
	install -m 0644 README $(TEXMFHOME)/doc/latex/skmath/README
	-mktexlsr

skmath.tds.zip: all
	mkdir -p skmath/tex/latex/skmath
	cp skmath.sty skmath/tex/latex/skmath/skmath.sty
	mkdir -p skmath/doc/latex/skmath
	cp skmath.pdf skmath/doc/latex/skmath/skmath.pdf
	mkdir -p skmath/source/latex/skmath
	cp skmath.tex skmath/source/latex/skmath/skmath.tex
	cp README skmath/doc/latex/skmath/README
	cd skmath && zip -r ../skmath.tds.zip *
	rm -rf skmath

skmath.tar.gz: all skmath.tds.zip
	mkdir -p skmath
	cp skmath.tex skmath/skmath.tex
	cp skmath.pdf skmath/skmath.pdf
	cp README skmath/README
	cp Makefile skmath/Makefile
	tar -czf $@ skmath skmath.tds.zip
	rm -rf skmath

dist: skmath.tar.gz

test:
	$(MAKE) -C tests

clean-test:
	$(MAKE) -C tests clean
