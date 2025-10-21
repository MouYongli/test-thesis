# Test Thesis

# Install

### 安装 texlive 和 latexmk
```bash
bash# Ubuntu/Debian
sudo apt update
sudo apt install texlive-full latexmk
```
### 或使用更新的版本
```bash
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzf install-tl-unx.tar.gz
cd install-tl-*
sudo ./install-tl
```
### 安装中文支持（如需要）：
```bash
sudo apt install texlive-lang-chinese texlive-xetex
```


## Local compilation

### Full compilation with bibliography
```bash
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```
Or use latexmk for automatic processing:
```bash
latexmk -pdf main.tex
```

## Using Makefile

The project includes a comprehensive Makefile for easy compilation:

```bash
# Build PDF with bibliography (default)
make

# Quick single-pass build
make quick

# Clean auxiliary files (keeps PDF)
make clean

# Clean everything including PDF
make distclean

# Clean and rebuild
make rebuild

# Auto-compile on file changes
make auto

# View PDF in default viewer
make view

# Show all available commands
make help
```

## CI/CD with GitHub Actions

This repository uses GitHub Actions to automatically compile the LaTeX document on every push to main.

### Deployment to GitHub Pages

The compiled PDF is automatically deployed to GitHub Pages. After pushing to main:

1. GitHub Actions will compile `main.tex`
2. The PDF is deployed to the `gh-pages` branch
3. Access your PDF at: `https://<username>.github.io/<repo-name>/main.pdf`
4. Or visit the homepage: `https://<username>.github.io/<repo-name>/`

### Enable GitHub Pages (First Time Setup)

1. Go to your repository on GitHub
2. Click **Settings** → **Pages**
3. Under "Source", select **Deploy from a branch**
4. Choose branch: **gh-pages** and folder: **/ (root)**
5. Click **Save**
6. Wait a few minutes for the first deployment

### Manual Push

```bash
git add .
git commit -m "Update thesis content"
git push origin main
```

The workflow will automatically:
- Compile the LaTeX document
- Upload PDF as an artifact (retained for 30 days)
- Deploy to GitHub Pages (accessible via URL)
- Create a release if you push a version tag (e.g., `v1.0`)