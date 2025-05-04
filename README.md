# LaTeX Template Build System

This project provides a `Makefile`-based build system for compiling LaTeX
templates (e.g., `arxiv`, `ieee`, `acm`) into PDFs.

## 📁 Directory Structure

```bash
.
├── Makefile
├── .latexmkrc
├── README.md
├── src/
│   ├── arxiv/
│   │   ├── main.tex
│   │   ├── references.bib
│   │   └── …
│   ├── ieee/
│   └── acm/
└── build/
```

- `src/<template>/`: LaTeX source files for each template.
- `build/<template>/`: Output directory for compiled results.

## 🔧 Environment Setup (macOS & Linux)

### 1. LaTeX Distribution

Install a full LaTeX distribution:

**macOS**:

```bash
brew install --cask mactex
```

Add to your path:
```bash
export PATH="/Library/TeX/texbin:$PATH"
```

Linux (Ubuntu/Debian):

```bash
sudo apt update
sudo apt install texlive-full
```

### 2. Build Tools

Ensure `make` and (optionally) `latexmk` are installed:

```bash
make --version
latexmk --version
```

To install `latexmk` on Linux:

```bash
sudo apt install latexmk
```

### 3. Build Instructions

#### Basic build (default backend)

```bash
make TEMPLATE=arxiv
```

This will:
* Copy all files from `src/arxiv` to `build/arxiv`
* Run pdflatex
* Automatically run bibtex if citations exist
* Automatically run makeglossaries if glossary files exist
* Finalize PDF in build/arxiv/main.pdf

#### Build using latexmk (recommended)

```bash
make TEMPLATE=arxiv USE_LATEXMK=1
```

### 4. Cleaning

Remove build files for a specific template:

```bash
make clean TEMPLATE=ieee
```

This deletes build/ieee.

### 5. latexmk Configuration (Optional)

This repository includes a `.latexmkrc` file to:
* Use the working build directory
* Automatically build glossaries
* Extend clean behavior

Ensure it’s present in the root directory when using `USE_LATEXMK=1`.

## Tested On
* macOS Ventura 13+ with MacTeX 2023
* Ubuntu 22.04 with TeX Live 2023

## Troubleshooting
* If bibtex or makeglossaries fails:
* Check that pdflatex was run at least once
* Verify .bib file exists and is referenced
* Ensure glossary commands (\makeglossaries, \printglossary) are used
* If pdflatex or latexmk not found:
* Confirm TeX binaries are in your $PATH

## Example Templates
* arxiv: `src/arxiv/main.tex` → `build/arxiv/main.pdf`
* IEEE conference: `src/ieee/main.tex` → `build/ieee/main.pdf`

Happy TeXing! ✨