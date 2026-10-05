SHELL := /bin/sh

SRC_DIR := src
BUILD_DIR := build
OUTPUT_DIR := output
TARGET := AlistairKungCV

.PHONY: all baseline clean check

all: $(OUTPUT_DIR)/$(TARGET).pdf

$(OUTPUT_DIR)/$(TARGET).pdf: $(SRC_DIR)/cv.tex $(SRC_DIR)/cv-style.tex
	@mkdir -p $(BUILD_DIR) $(OUTPUT_DIR)
	@if command -v latexmk >/dev/null 2>&1; then \
		latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=$(BUILD_DIR) $(SRC_DIR)/cv.tex; \
	elif command -v pdflatex >/dev/null 2>&1; then \
		pdflatex -interaction=nonstopmode -halt-on-error -output-directory=$(BUILD_DIR) $(SRC_DIR)/cv.tex; \
		pdflatex -interaction=nonstopmode -halt-on-error -output-directory=$(BUILD_DIR) $(SRC_DIR)/cv.tex; \
	elif command -v tectonic >/dev/null 2>&1; then \
		tectonic --outdir $(BUILD_DIR) $(SRC_DIR)/cv.tex; \
	else \
		echo "No TeX engine found. Install MacTeX/TeX Live (latexmk or pdflatex) or tectonic." >&2; \
		exit 1; \
	fi
	@cp $(BUILD_DIR)/cv.pdf $@

baseline: $(SRC_DIR)/cv-baseline.tex $(SRC_DIR)/cv-style.tex
	@mkdir -p $(BUILD_DIR)/baseline $(OUTPUT_DIR)
	@if command -v latexmk >/dev/null 2>&1; then \
		latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=$(BUILD_DIR)/baseline $(SRC_DIR)/cv-baseline.tex; \
	elif command -v pdflatex >/dev/null 2>&1; then \
		pdflatex -interaction=nonstopmode -halt-on-error -output-directory=$(BUILD_DIR)/baseline $(SRC_DIR)/cv-baseline.tex; \
		pdflatex -interaction=nonstopmode -halt-on-error -output-directory=$(BUILD_DIR)/baseline $(SRC_DIR)/cv-baseline.tex; \
	elif command -v tectonic >/dev/null 2>&1; then \
		tectonic --outdir $(BUILD_DIR)/baseline $(SRC_DIR)/cv-baseline.tex; \
	else \
		echo "No TeX engine found. Install MacTeX/TeX Live (latexmk or pdflatex) or tectonic." >&2; \
		exit 1; \
	fi
	@cp $(BUILD_DIR)/baseline/cv-baseline.pdf $(OUTPUT_DIR)/AlistairKungCV2025-baseline.pdf

check:
	@if command -v chktex >/dev/null 2>&1; then chktex -q -n 1 -n 8 -n 13 -n 24 $(SRC_DIR)/cv.tex; else echo "chktex not installed; skipping lint."; fi

clean:
	@rm -rf $(BUILD_DIR)
	@rm -f $(OUTPUT_DIR)/$(TARGET).pdf $(OUTPUT_DIR)/AlistairKungCV2025-baseline.pdf

