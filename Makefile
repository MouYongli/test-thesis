# LaTeX Makefile
# Main LaTeX file
MAIN = main
TEX = $(MAIN).tex
PDF = $(MAIN).pdf
BIB = ref.bib

# LaTeX compiler
LATEX = pdflatex
BIBTEX = bibtex
LATEXMK = latexmk

# Compiler flags
LATEX_FLAGS = -interaction=nonstopmode -file-line-error -halt-on-error

# Default target
.PHONY: all
all: $(PDF)

# Build PDF with full bibliography support
$(PDF): $(TEX) $(BIB)
	$(LATEX) $(LATEX_FLAGS) $(MAIN)
	$(BIBTEX) $(MAIN)
	$(LATEX) $(LATEX_FLAGS) $(MAIN)
	$(LATEX) $(LATEX_FLAGS) $(MAIN)

# Quick build (single pass, no bibliography)
.PHONY: quick
quick:
	$(LATEX) $(LATEX_FLAGS) $(MAIN)

# Use latexmk for automatic compilation
.PHONY: auto
auto:
	$(LATEXMK) -pdf -pvc $(MAIN)

# Build using latexmk (handles everything automatically)
.PHONY: latexmk
latexmk:
	$(LATEXMK) -pdf $(MAIN)

# Clean auxiliary files
.PHONY: clean
clean:
	rm -f *.aux *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk
	rm -f *.bbl *.blg *.bcf *.run.xml *.synctex.gz
	rm -f *.nav *.snm *.vrb *.dvi *.ps
	rm -f *.idx *.ilg *.ind *.lol *.ist
	rm -f *.glg *.glo *.gls *.alg *.acr *.acn
	rm -f *.cb *.cb2 *.lb *.xdv *.fot *.fmt
	rm -f *-converted-to.*
	rm -f *.backup *~
	rm -f $(MAIN).pdf

# Clean everything including PDF
.PHONY: distclean
distclean: clean
	rm -f $(PDF)

# Clean and rebuild
.PHONY: rebuild
rebuild: clean all

# View PDF (Linux)
.PHONY: view
view:
	@if [ -f $(PDF) ]; then \
		xdg-open $(PDF) 2>/dev/null || evince $(PDF) 2>/dev/null || okular $(PDF) 2>/dev/null || echo "No PDF viewer found"; \
	else \
		echo "PDF not found. Run 'make' first."; \
	fi

# Count words in document (requires texcount)
.PHONY: count
count:
	@texcount -inc -incbib $(MAIN).tex 2>/dev/null || echo "texcount not installed"

# Check LaTeX installation
.PHONY: check
check:
	@echo "Checking LaTeX installation..."
	@which pdflatex > /dev/null && echo "✓ pdflatex found" || echo "✗ pdflatex not found"
	@which bibtex > /dev/null && echo "✓ bibtex found" || echo "✗ bibtex not found"
	@which latexmk > /dev/null && echo "✓ latexmk found" || echo "✗ latexmk not found"

# Help
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  make          - Build PDF with bibliography (default)"
	@echo "  make quick    - Quick build (single pass, no bib)"
	@echo "  make latexmk  - Build using latexmk"
	@echo "  make auto     - Auto-compile on file changes (latexmk -pvc)"
	@echo "  make clean    - Remove auxiliary files"
	@echo "  make distclean- Remove all generated files including PDF"
	@echo "  make rebuild  - Clean and rebuild"
	@echo "  make view     - Open PDF in viewer"
	@echo "  make count    - Count words (requires texcount)"
	@echo "  make check    - Check LaTeX installation"
	@echo "  make help     - Show this help message"
