# Longitudinal Data Analysis in R

**Course provenance.** I took **BIOS767: Longitudinal Data Analysis** in Spring 2026. The course materials form the main backbone of this repository, supplemented by the cited notes, assignments, and external references.

> [**Practical analysis roadmap**](references/roadmap.qmd) — Route a real-data exam problem from outcome and estimand through modeling, missingness, inference, diagnostics, sensitivity analysis, and reporting.

Each chapter is self-contained and sources `_common.R`. Render the project from this directory so relative paths and the shared setup resolve correctly.

## Analysis in R

### [00-data-manipulation-tables.qmd](analysis-in-r/00-data-manipulation-tables.qmd)

- High-frequency `dplyr` verbs for selecting, filtering, recoding, grouping, and summarizing exam datasets.
- Counts, proportions, missingness summaries, long/wide reshaping, joins, and row binding.
- Basic publication-ready table output with `knitr::kable()`.

### [00-visualization.qmd](analysis-in-r/00-visualization.qmd)

- Common `ggplot2` displays for distributions, grouped proportions, associations, and longitudinal profiles.
- Estimate/interval plots, adjusted prediction curves, faceting, and model diagnostics.
- Concise labeling, denominator, null-line, and export guidance for exam figures.

### [01-eda-descriptive.qmd](analysis-in-r/01-eda-descriptive.qmd)

- Individual spaghetti plots for heterogeneity, outliers, nonlinear trajectories, and irregular observation times.
- Group-specific mean profiles with pointwise standard-error bands.
- Occasion-specific sample covariance and correlation matrices.
- Empirical variograms for assessing dependence as a function of time lag.
- Visit- and subject-level missing-data pattern displays.

### [02-rm-anova-manova.qmd](analysis-in-r/02-rm-anova-manova.qmd)

- Univariate repeated-measures ANOVA and the sphericity assumption.
- Greenhouse–Geisser and Huynh–Feldt corrections.
- Multivariate repeated-measures tests using Pillai, Wilks, Hotelling–Lawley, and Roy statistics.
- Profile-analysis tests of parallelism, coincidence, and flatness.
- `emmeans` interaction contrasts, joint tests, multiplicity adjustment, and repeated-measures power calculations.

### [03-linear-mixed-models.qmd](analysis-in-r/03-linear-mixed-models.qmd)

- Marginal Gaussian models with CS, AR(1), continuous-time AR(1), spatial, Toeplitz, and unstructured covariance.
- Covariance and mean-model comparison using likelihood-ratio tests, AIC, and BIC.
- ML versus REML for fixed-effect comparison and variance-component estimation.
- Random-intercept and random-slope models, BLUP extraction, variance components, and ICCs.
- Profile-likelihood confidence intervals and Kenward–Roger or Satterthwaite small-sample inference.
- Boundary-aware variance-component tests and singular-fit or convergence troubleshooting.
- Nested, crossed, and nonlinear mixed-effects models.

### [04-marginal-models-gee.qmd](analysis-in-r/04-marginal-models-gee.qmd)

- Population-averaged mean models defined through generalized estimating equations.
- Independence, exchangeable, AR(1), and unstructured working correlations.
- Working-correlation comparison with QIC.
- Sandwich versus model-based standard errors and GEE scale estimation.
- Within-subject and between-subject decomposition of time-varying covariates.
- Population-averaged GEE versus subject-specific GLMM interpretation and attenuation under nonlinear links.

### [05-glm-review.qmd](analysis-in-r/05-glm-review.qmd)

- Exponential-family distributions, mean–variance relationships, and link functions.
- Logistic, Poisson, negative-binomial, and Gaussian regression specifications.
- Exposure offsets and rate-ratio interpretation.
- Pearson and deviance diagnostics for overdispersion.
- Cumulative-link models for ordinal longitudinal responses.

### [06-glmm.qmd](analysis-in-r/06-glmm.qmd)

- Subject-specific generalized linear mixed models for binary and count responses.
- Laplace and adaptive Gauss–Hermite quadrature approximations to the marginal likelihood.
- Conditional odds ratios or rate ratios and their relationship to population-averaged effects.
- Overdispersion and zero-inflation diagnostics.
- `glmmTMB` models for negative-binomial, zero-inflated, and offset-based analyses.
- Transition models conditional on lagged response history.

### [07-missing-data.qmd](analysis-in-r/07-missing-data.qmd)

- MCAR, MAR, and MNAR observation mechanisms and their inferential implications.
- Limitations of complete-case analysis and last observation carried forward.
- EM estimation and longitudinal multiple imputation with Rubin-rule pooling.
- Dropout-probability models, inverse-probability weighting, and weighted GEE.
- Selection and pattern-mixture formulations for MNAR sensitivity analysis.

### [08-multivariate-testing-pca.qmd](analysis-in-r/08-multivariate-testing-pca.qmd)

- Hotelling and MANOVA tests for correlated multivariate response vectors.
- PCA based on covariance or correlation matrices, including loadings, scores, and explained variance.
- Factor-analysis covariance models and their distinction from PCA.
- Principal-coordinate analysis and multidimensional scaling based on pairwise distances.

## Accompanying Mathematics

### [Mathematical writeup catalogue](math-writeups/00-index.qmd)

- Thirteen technical companions covering model formulation, assumptions, estimation, inference, interpretation, and use.
- Concise citations use the slide number printed in the lower-left corner of each BIOS767 lecture deck.
- Reciprocal links connect every analysis chapter and reference page to the relevant mathematics.

## Reference

### [roadmap.qmd](references/roadmap.qmd)

- A 60-second route from outcome scale and objective to estimand, model class, dependence structure, inference, diagnostics, and reporting.
- Outcome-first and question-signal lookup tables linking to the matching R workflow and mathematical companion.
- Model-selection, missingness, sensitivity-analysis, and applied-exam cross-check rules.

### [A0-setup-packages-data.qmd](references/A0-setup-packages-data.qmd)

- One-shot installation of every package used by the manual and available applied-exam solutions.
- Repository-relative construction and validation of exam-year data paths.
- Usage of `read.csv()`, `read.table()`, `read.csv2()`, and `readxl::read_excel()`.
- Post-import checks for dimensions, names, types, sample records, and missingness.

### [A1-inference-diagnostics.qmd](references/A1-inference-diagnostics.qmd)

- ML/REML model-comparison rules, information criteria, and boundary-aware likelihood-ratio testing.
- Marginal, conditional, Pearson, and deviance residuals.
- Residual-versus-fitted plots and normal Q–Q plots for residuals and BLUPs.
- Subject-level influence and Cook’s-distance diagnostics.
- Residual variograms, overdispersion checks, singular-fit detection, and convergence assessment.

### [A2-interpretation-cheatsheet.qmd](references/A2-interpretation-cheatsheet.qmd)

- Copy-ready scientific interpretation templates for LM, Gaussian marginal models, LMM, GLM, GEE, GLMM, ordinal/nominal models, transition models, and two-part count models.
- Mean differences, odds/risk/rate ratios, time slopes, interactions, random effects, ICCs, and standardized probabilities.
- Population-average, subject/cluster-specific, and response-history-conditional estimands.
- Calibrated confidence-interval language, causal versus associational wording, and prediction-versus-effect distinctions.
- An exam-speed template table, final checklist, and common wording corrections.

### [A3-packages.qmd](references/A3-packages.qmd)

- Visualization and data-management packages for longitudinal data.
- Packages for repeated-measures ANOVA, LMMs, GEE, GLMMs, and nonlinear mixed models.
- Packages for missing-data analysis, contrasts, small-sample inference, and marginal effects.
- Packages for residual diagnostics, influence assessment, model summaries, and reproducible output.
