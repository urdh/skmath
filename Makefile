.PHONY: all clean distclean
all: skmath.pdf
clean:
	rm -f *.sty
distclean: clean

%.pdf:
	pdflatex $*.tex
	makeglossaries $*
	pdflatex $*.tex
	makeglossaries $*
	pdflatex $*.tex

%.sty: $*.pdf
