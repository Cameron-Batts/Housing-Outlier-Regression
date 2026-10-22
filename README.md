# Housing Regression Diagnostics and Price Sensitivity

**Author:** Cameron Batts

## Validation update - October 22, 2026

The revised R workflow executed and rendered. Before/after data contain 1,933/986 rows; complete-case model samples contain 1,910/981. All 30 flagged scenario prices were replaced in the hypothetical demonstration. Fitting R² changed from 0.8691 to 0.9213; this is not predictive validation or evidence of fraud. A ggfortify/na.exclude diagnostic mismatch was fixed with native lm diagnostic plots, and crowded facet axes were reformatted. Model formulas and the scenario assumptions were preserved.

[Aggregate validation record](Reports/validation_results.json). [Executed R workflow](Reports/executed_workflow.html) · [Recorded R environment](Reports/validated_session.txt).

Run `Rscript validation/rerun_analysis.R` from the project root.

## Problem
Investigate repeated sale prices, model assumptions and sensitivity to model-based target replacement.

## Approach
Inspect the provided pre/post-2009 files, fit a fixed 15-term regression specification, compare diagnostic plots and retain raw targets separately from an optional replacement scenario.

## Reported results
Data checks found 1,933 earlier and 986 later records, each with 82 columns including an exported row index. Thirty later records share the exact sale price $142,769.70, compared with zero earlier records. They span ten neighborhoods, including nine Gilbert and four NAmes observations.

## Limitations and corrections
Repeated prices, density peaks and residual patterns do not establish fraud. The original workflow replaced flagged targets with model predictions plus 1% noise; smoother residuals after that operation do not validate recovered prices or independent predictive accuracy. No held-out evaluation was reported. Existing images and PDF contain historical wording and interpretations that predate this correction.

## Verification
Dataset dimensions, missingness and relevant counts were checked directly. The revised R workflow was executed and rendered during this pass. Fresh revised-workflow metrics are reported separately from the archive; no operational benefit is claimed.

## Data
The included data have no documented upstream source or redistribution license in the original repository. Preserve provenance when it becomes available.

## Run
Install R and Pandoc (or use RStudio), then run from the repository root:
```r
source("install.R")
rmarkdown::render("Notebooks/housing_outlier_regression.Rmd")
```
Tested numerical/NLP packages are recorded in requirements-validation.txt.

## Files
- [R Markdown analysis](Notebooks/housing_outlier_regression.Rmd)
- [Readable report](Reports/housing_outlier_regression.html)
- [Original PDF](Reports/Housing%20Market%20Outlier%20Detection%20%26%20Regression%20Analysis.pdf) — historical export; conclusions may predate the corrections above.
- [Live portfolio report](https://cameron-batts.github.io/housing_outlier_regression.html)
