.PHONY: all clean distclean
all: skmath.pdf
clean:
	rm -f *.sty
distclean: clean

%.pdf: %.tex
	pdflatex $<
	makeglossaries $*
	pdflatex $<
	makeglossaries $*
	pdflatex $<

%.sty: %.pdf
