# Build the thesis book with pdflatex + bibtex.
MAIN ?= main
LATEX ?= pdflatex -interaction=nonstopmode -halt-on-error -file-line-error

.PHONY: all cover clean
all: $(MAIN).pdf

$(MAIN).pdf: $(wildcard *.tex *.cls *.bst *.bib */*.tex)
	$(LATEX) $(MAIN)
	bibtex $(MAIN)
	$(LATEX) $(MAIN)
	$(LATEX) $(MAIN)

cover: sampul.pdf
sampul.pdf: sampul.tex config/metadata.tex
	$(LATEX) sampul
	$(LATEX) sampul

clean:
	rm -f *.aux *.bbl *.blg *.lof *.lot *.log *.out *.toc */*.aux
