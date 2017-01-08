[![Travis CI](https://img.shields.io/travis/urdh/skmath/master.svg)](http://travis-ci.org/urdh/skmath)
[![CTAN: Version](https://img.shields.io/ctan/v/skmath.svg)](http://www.ctan.org/pkg/skmath)
[![CTAN: License](https://img.shields.io/ctan/l/skmath.svg)](http://www.ctan.org/pkg/skmath)
```
%% skmath improved math commands
%%
%% Copyright (C) 2012-2016 by Simon Sigurdhsson <sigurdhsson@gmail.com>
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainer of this work is Simon Sigurdhsson.
%%
%% This work consists of the file skmath.tex
%% and the derived file skmath.sty.

This is version 0.4b of the skmath package, a package which provides
improved and new math commands for superior typesetting with lower effort.

The following files are enclosed.

  README        - This file
  Makefile      - GNU Makefile for making the package and documentation
  skmath.tex    - LaTeX source code of the package and documentation
  skmath.pdf    - PDF version of the documentation

Installation notes:
The easiest way to install this package, assuming you have obtained the
source code from Github or CTAN, is to simply run `make install`. This
will generate package code and documentation, install it into TEXMFHOME
and run `mktexlsr`. If you wish to compile the package but not install
it, run `make all` instead. If you insist on doing it manually, remember
that you must use `pdflatex` (not `tex` or `latex`).
```
