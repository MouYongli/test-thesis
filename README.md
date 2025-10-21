# Test Thesis

Local compilation test:
# Full compilation with bibliography
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex

Or use latexmk for automatic processing:
latexmk -pdf main.tex

CI/CD test:
# Stage and commit the files
git add main.tex ref.bib .github/workflows/latex.yml
git commit -m "Add test LaTeX content and enhance CI/CD workflow"
git push origin main
