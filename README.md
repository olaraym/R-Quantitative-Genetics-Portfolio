<div align="center">

# 📊 R for Quantitative Genetics

**From R fundamentals to QTL mapping: a reproducible portfolio of R Markdown analyses for plant and animal genetics**

[![Render reports](https://github.com/olaraym/R-Quantitative-Genetics-Portfolio/actions/workflows/render-reports.yml/badge.svg)](https://github.com/olaraym/R-Quantitative-Genetics-Portfolio/actions/workflows/render-reports.yml)
[![Reports](https://img.shields.io/badge/reports-GitHub%20Pages-2ea44f?style=flat-square)](https://olaraym.github.io/R-Quantitative-Genetics-Portfolio/)
![R](https://img.shields.io/badge/R-%3E%3D4.2-276DC3?style=flat-square&logo=r&logoColor=white)
![R Markdown](https://img.shields.io/badge/R%20Markdown-knitr-1f77b4?style=flat-square)
![R/qtl](https://img.shields.io/badge/R%2Fqtl-QTL%20mapping-6a3d9a?style=flat-square)
[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue?style=flat-square)](LICENSE)

</div>

---

## 🌱 About

This repository collects the R analyses I wrote while training in plant breeding and quantitative genetics. It starts with core R skills, moves through checking marker data, and ends with full QTL mapping. Every report is written in R Markdown, reads its data from `data/`, and is re-rendered automatically by GitHub Actions on each push.

👉 **Read the rendered reports:** <https://olaraym.github.io/R-Quantitative-Genetics-Portfolio/>

## 📑 Reports

| # | Report | What it shows | Key R skills |
|---|---|---|---|
| 01 | [R fundamentals and data wrangling](analysis/01_r_fundamentals_and_data_wrangling.Rmd) | Vectors, indexing, logical selection; importing and cleaning a 200-student data set, including `-99` missing codes | `c()`, `seq()`, `rep()`, `[]`, `read.csv()`, `dplyr::filter/select/mutate/across`, `na_if()` |
| 02 | [Exploring marker data in a mouse backcross](analysis/02_marker_data_exploration.Rmd) | Genotype heatmap, crossover patterns, genotype counts, and a single-marker scan for body weight | `image()`, `for`/`while`, `sapply()`, `lm()`, `anova()`, base graphics |
| 03 | [Segregation distortion tests](analysis/03_segregation_distortion_tests.Rmd) | Chi-square goodness-of-fit for backcross (1:1) and F2 (1:2:1) populations, with Bonferroni correction | Writing functions, `chisq.test()`, multiple-testing correction, `knitr::kable()` |
| 04 | [QTL mapping of maize plant height](analysis/04_qtl_mapping_maize.Rmd) | SMA → interval mapping → composite interval mapping → multiple-QTL model with permutation thresholds | `qtl::scanone`, `cim`, `makeqtl`, `fitqtl`, `refineqtl`, `scantwo`, `stepwiseqtl` |

## 🧬 Genetics behind the code

* **Backcross vs F2:** a backcross gives two genotype classes per marker (expected 1:1). An F2 intercross gives three (1:2:1). Report 03 tests each marker against its expected ratio before the marker is used for mapping.
* **Multiple testing:** with *m* markers, testing each at α = 0.05 inflates false positives. The Bonferroni threshold α/*m* controls the family-wise error rate.
* **QTL methods:**
  * Single-marker analysis tests markers only.
  * Interval mapping also tests positions between markers, using genotype probabilities.
  * Composite interval mapping adds marker cofactors that absorb other QTL, which sharpens peaks.
  * Multiple-QTL models estimate several QTL, their effects and their interactions together.
* **Permutation thresholds:** shuffling phenotypes 1,000 times gives an empirical genome-wide significance level, without assuming a distribution for the LOD scores.

## 📁 Repository structure

```text
.
├── analysis/                    # R Markdown reports (source of truth)
│   ├── 01_r_fundamentals_and_data_wrangling.Rmd
│   ├── 02_marker_data_exploration.Rmd
│   ├── 03_segregation_distortion_tests.Rmd
│   └── 04_qtl_mapping_maize.Rmd
├── data/                        # Input data sets
│   ├── Students.csv             # 200 students × 13 variables (course data set)
│   ├── mouse.csv                # Backcross: 103 mice × 14 markers + body weight
│   └── maize.csv                # F2: 171 plants × 12 markers + grain yield
├── render_site.R                # Renders all reports + landing page into _site/
├── .github/workflows/
│   └── render-reports.yml       # CI: render on push, deploy to GitHub Pages
├── R-Quantitative-Genetics-Portfolio.Rproj
└── LICENSE
```

## 🚀 Reproduce locally

```r
install.packages(c("rmarkdown", "knitr", "dplyr", "qtl"))
source("render_site.R")      # outputs to _site/
```

Or open `R-Quantitative-Genetics-Portfolio.Rproj` in RStudio and knit any file in `analysis/`.

> Report 04 needs the R/qtl cross object `data/maize_mds.RData`. Until that file is added, the report shows the code without running it.

## 🎓 Context

Most of this work began as coursework in an experimental design and QTL mapping course during my Erasmus Mundus Master's in Plant Breeding (emPLANT+) in 2022. In November 2026 I revised it into a reproducible portfolio:
* fixed bugs, such as a heatmap that plotted the wrong data set and an exclusive bound in a filter
* replaced repeated code with functions
* added missing-value handling
* set up continuous rendering

## 👤 Author

**Laide Abbas Rasaki** · [![ORCID](https://img.shields.io/badge/ORCID-0000--0002--5594--6827-A6CE39?style=flat-square&logo=orcid&logoColor=white)](https://orcid.org/0000-0002-5594-6827) · [GitHub @olaraym](https://github.com/olaraym)

See also: [DNA methylation analysis in table beet](https://github.com/olaraym/DNA_Methylation-Analyis-in-Table-beet) (*Scientific Reports*, 2026)
