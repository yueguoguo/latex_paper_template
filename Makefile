# Makefile for building LaTeX templates with optional BibTeX and glossary support
# Supports optional use of latexmk

TEMPLATE ?= arxiv
USE_LATEXMK ?= 0

SRC_DIR := src/$(TEMPLATE)
BUILD_DIR := build/$(TEMPLATE)

LATEX := pdflatex
LATEX_OPTS := -interaction=nonstopmode -output-directory=.

MAIN_TEX := $(shell find $(SRC_DIR) -maxdepth 1 -name '*.tex' | head -n 1)
MAIN_TEX_BASENAME := $(notdir $(MAIN_TEX))
MAIN_NAME := $(basename $(MAIN_TEX_BASENAME))
PDF_OUTPUT := $(BUILD_DIR)/$(MAIN_NAME).pdf

.PHONY: all clean

all: $(PDF_OUTPUT)

$(PDF_OUTPUT): $(MAIN_TEX)
	@mkdir -p $(BUILD_DIR)
	@cp $(SRC_DIR)/* $(BUILD_DIR)/

ifeq ($(USE_LATEXMK), 1)
	cd $(BUILD_DIR) && latexmk -pdf -interaction=nonstopmode $(MAIN_TEX_BASENAME)
else
	cd $(BUILD_DIR) && $(LATEX) $(LATEX_OPTS) $(MAIN_TEX_BASENAME)

	@if grep -q '\\citation' $(BUILD_DIR)/$(MAIN_NAME).aux 2>/dev/null; then \
		echo "Running bibtex..."; \
		cd $(BUILD_DIR) && bibtex $(MAIN_NAME); \
	fi

	@if [ -f $(BUILD_DIR)/$(MAIN_NAME).glo ]; then \
		echo "Running makeglossaries..."; \
		cd $(BUILD_DIR) && makeglossaries $(MAIN_NAME); \
	fi

	cd $(BUILD_DIR) && $(LATEX) $(LATEX_OPTS) $(MAIN_TEX_BASENAME)
	cd $(BUILD_DIR) && $(LATEX) $(LATEX_OPTS) $(MAIN_TEX_BASENAME)
endif

clean:
	@rm -rf $(BUILD_DIR)