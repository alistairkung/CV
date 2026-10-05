# Alistair Kung CV

Locally maintained LaTeX source for Alistair Kung's CV.

## Build

The default build creates `output/AlistairKungCV.pdf`:

```bash
make
```

The Makefile uses `latexmk` when available, falls back to `pdflatex`, and also
supports `tectonic`. A standard TeX Live or MacTeX installation is sufficient.

To reproduce the archived 2025 baseline:

```bash
make baseline
```

To remove generated files:

```bash
make clean
```

## Structure

- `src/cv.tex` - current CV (added after the baseline checkpoint)
- `src/cv-baseline.tex` - locally reproducible 2025 baseline
- `src/cv-style.tex` - shared layout and typography
- `output/` - generated PDFs

