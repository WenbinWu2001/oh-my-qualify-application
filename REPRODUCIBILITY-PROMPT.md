# Master prompt: build a course-based mathematical and practical analysis manual

Copy the prompt below into an AI coding-agent session. Replace every angle-bracket placeholder before starting. Preserve the requirements unless they conflict with the source course or the user's explicit instructions.

---

## Role and objective

You are building a rigorous, reproducible reference repository from the materials of:

- Course code: `<COURSE_CODE>`
- Course title: `<COURSE_TITLE>`
- Institution: `<INSTITUTION>`
- Term: `<TERM>`
- Programming language: `<PROGRAMMING_LANGUAGE>`; set this to `R` for an R-based manual
- Primary lecture materials: `<LECTURE_SLIDES_DIR>`
- Course assignments and solutions: `<COURSE_ASSIGNMENTS_DIR>`
- Supplementary course notes: `<SUPPLEMENTARY_NOTES_DIR>`
- External course/reference materials, if authorized: `<EXTERNAL_REFERENCE_DIRS>`
- Previous applied exams and data: `<PREVIOUS_EXAMS_DIR>`
- Repository root to create or update: `<REPO_ROOT>`
- Intended public site URL: `<SITE_URL>`
- Default git branch: `<DEFAULT_BRANCH>`

Create a technical manual that connects three products:

1. **Analysis in code:** executable, topic-based practical chapters.
2. **Accompanying mathematics:** concise mathematical formulations, assumptions, estimation, inference, and interpretation.
3. **Previous-exam solutions:** worked solutions that explicitly reuse and link to the curated manual.

The result must function both as a study book and as an open-book analysis reference. The primary course lecture slides are the backbone. Supplementary notes, assignments, external references, and standard-practice additions may fill gaps, but they must never silently replace or distort the course's scope, notation, or inferential conventions.

Mathematical and statistical accuracy is the highest priority. Never guess a formula, assumption, likelihood, covariance expression, asymptotic reference distribution, software default, or interpretation. If a point cannot be verified, flag it explicitly and state what source coverage is missing.

## Non-negotiable principles

1. Read the course materials thoroughly before drafting. Do not infer the syllabus from filenames alone.
2. Organize by statistical topic and model, not by the physical order of files.
3. Preserve a traceable path from each important statement to its source and from each model to executable code.
4. Use the primary lecture slides as the default authority for course scope and notation.
5. Distinguish clearly among:
   - results directly supported by course materials;
   - standard-practice implementation added to make the manual executable;
   - external verification or clarification;
   - exam-specific extensions outside the manual's core scope.
6. Translate methods from other software into idiomatic `<PROGRAMMING_LANGUAGE>` code. Reproduce statistical functionality, not surface syntax.
7. Keep the manual self-contained and reproducible. Prefer built-in or openly available example datasets for manual chapters. Do not make the public manual depend on private exam data.
8. Use only relative repository links. Never write machine-specific absolute paths into source files, rendered pages, code, or citations.
9. Do not overwrite, rename, move, or edit source lecture notes, assignments, exam PDFs, or raw datasets.
10. Skip proofs in the mathematical companions. State the result and cite the slide or document page containing the proof.
11. Verify the initial mathematical draft against authoritative external sources. Prefer primary papers, authoritative textbooks, and official software documentation.
12. Render and inspect the complete site before claiming completion.

## Required final architecture

Use this structure unless the existing repository requires a compatible variation:

```text
<REPO_ROOT>/
├── .github/
│   └── workflows/
│       └── publish.yml
├── .gitignore
├── _quarto.yml
├── index.qmd
├── 00-INDEX.md
├── _common.R
├── analysis-in-r/
│   ├── 01-<topic-slug>.qmd
│   ├── 02-<topic-slug>.qmd
│   └── ...
├── math-writeups/
│   ├── 00-index.qmd
│   ├── 01-<mathematical-topic>.qmd
│   ├── 02-<mathematical-topic>.qmd
│   └── ...
├── references/
│   ├── A1-<reference-topic>.qmd
│   ├── A2-<reference-topic>.qmd
│   └── A3-packages.qmd
└── exam-solutions/
    ├── README.md
    ├── _manual_bridge.R
    ├── applied-<YEAR>-solution.Rmd
    └── ...
```

If exam solutions must remain outside `<REPO_ROOT>`, retain the same logical structure and use a relative root-discovery helper. Do not hardcode a local filesystem path.

The public site sidebar and landing-page catalogue must use this order:

1. Topic catalogue
2. Analysis in `<PROGRAMMING_LANGUAGE>`
3. Accompanying Mathematics
4. Reference

Use stable topic identifiers such as `01-data-exploration`, `02-repeated-measures`, and `A1-inference-diagnostics`. Once exam solutions link to these identifiers, do not rename them without updating all reciprocal links.

## Phase 1: inspect, inventory, and map all source materials

### 1.1 Read the repository instructions

Before changing files:

- inspect `README`, `AGENTS.md`, `CONTRIBUTING`, existing Quarto configuration, environment files, and git status;
- identify protected source directories;
- identify any existing user changes and preserve unrelated work;
- determine available PDF, document, R, SAS, Stata, Python, notebook, and data files;
- determine whether the repository is already a git repository and whether GitHub Pages is already configured.

### 1.2 Build a source inventory

Create a working inventory with at least:

| Source | Source type | Stable citation label | Topics | Has mathematics? | Has code? | Has data? | Priority |
|---|---|---|---|---:|---:|---:|---|
| `<LECTURE_DECK>` | lecture slides | `<PDF_BASENAME>` | `<TOPICS>` | yes/no | yes/no | yes/no | primary |

For every PDF:

- record the PDF basename;
- inspect the table of contents, section breaks, and all pages relevant to models or analysis;
- determine whether the visible slide number differs from the PDF's one-based page number;
- for slide decks, record the slide number printed on the slide, normally in the lower-left corner;
- for documents without printed slide numbers, record the visible document page number;
- note whether annotations or renamed prefixes alter local filenames.

For every course code file:

- identify the homework, lab, lecture, or example from which it came;
- record the statistical purpose, model, software, data assumptions, output extraction, diagnostics, and interpretation;
- note software defaults that may differ from the target language;
- do not copy blindly: determine the underlying statistical operation.

For every previous exam:

- inspect the exam PDF and its same-year data and codebook together;
- list each subquestion, requested estimand, data structure, candidate model, diagnostics, and reporting requirement;
- record topics outside the manual's intended scope as exam-specific extensions;
- record missing exams or missing data explicitly rather than inventing a solution.

### 1.3 Create a topic coverage matrix

Before drafting chapters, create a many-to-many map:

| Topic ID | Topic/model | Lecture sources | Assignment sources | Code chapter | Math writeup | Exam years/questions | External checks |
|---|---|---|---|---|---|---|---|
| `01-...` | `<TOPIC>` | `<DECK>, slides ...` | `<COURSE> Homework ...` | `01-....qmd` | `math-writeups/....qmd` | `<YEAR Q...>` | `<PRIMARY SOURCE>` |

Use the matrix to:

- merge duplicate coverage across decks;
- separate mathematically distinct estimands or model families;
- identify a topic with mathematics but no code;
- identify code with no mathematical explanation;
- identify exam methods not represented in the manual;
- identify gaps requiring a standard idiomatic implementation;
- prevent omissions and unnecessary chapters.

Do not draft final prose until this inventory and topic map are coherent.

## Phase 2: define the statistical scope

Let the course materials determine the exact chapter list. Typical applied-statistics categories may include:

- data structure, exploratory analysis, visualization, and missingness patterns;
- repeated-measures ANOVA, MANOVA, profile analysis, and planned contrasts;
- covariance models and generalized least squares;
- linear mixed models, multilevel models, and nonlinear mixed models;
- generalized linear models;
- marginal models and generalized estimating equations;
- generalized linear mixed models;
- ordinal, nominal, transition, joint, or multistate models;
- missing-data likelihoods, EM, multiple imputation, weighting, and sensitivity analysis;
- time-varying covariates;
- multivariate testing, dimension reduction, or functional methods;
- sample size and power;
- inference, diagnostics, interpretation, and package references.

These are examples, not permission to expand the syllabus. Include a topic only if it is:

1. in the authorized course sources;
2. necessary to implement or interpret a covered method; or
3. explicitly requested as a clearly labeled extension.

When previous exams contain out-of-scope methods, solve them only in the exam solution and label them **Exam-specific extension beyond the manual**. Do not distort the core manual to absorb every exam topic.

## Phase 3: scaffold the reproducible analysis manual

### 3.1 Shared setup

Create `_common.R` containing only genuinely shared behavior:

- deterministic random seed;
- display and contrast options;
- required-package checks with actionable error messages;
- shared plotting theme;
- small, tested helper functions used by multiple chapters;
- no private data loading;
- no machine-specific paths;
- no large model fits at source time.

Prefer explicit namespace calls such as `package::function()` in reusable helpers. Load only the packages needed by each chapter. Optional packages must be guarded by `requireNamespace()` and the text must explain what is skipped when absent.

For an R manual, common helper functions may include:

- coefficient and confidence-interval extraction;
- exponentiated odds/rate-ratio tables;
- linear contrasts;
- robust versus model-based GEE covariance extraction;
- ICC extraction;
- prediction or classification metrics;
- compact table formatting.

Test every helper independently before using it across chapters.

### 3.2 Package catalogue first

Draft `references/A3-packages.qmd` before the model chapters. Group packages by task:

- data management and visualization;
- Gaussian repeated measures and LMMs;
- GEE and marginal models;
- GLMMs and nonlinear models;
- missing data and weighting;
- contrasts, predictions, and inference;
- diagnostics and influence;
- tidying and reproducible output.

For each package, state in one concise line:

- its main role;
- the relevant functions;
- important limitations or defaults.

Use the package catalogue to determine the required packages for local rendering and continuous integration.

### 3.3 Exact analysis-chapter template

Every main analysis chapter under `analysis-in-r/` must follow this structure:

````markdown
---
title: "<NUMBER>. <TECHNICAL TOPIC TITLE>"
format: html
execute: {echo: true, warning: false, message: false}
---

::: {.callout-note title="Mathematical companion[s]"}
[<MATH TOPIC>](../math-writeups/<MATH_FILE>.qmd)
:::

```{r}
#| label: setup
#| include: false
source("_common.R") # `_quarto.yml` sets `execute-dir: project`
library(<REQUIRED_PACKAGE>)
```

## 1. Aim

## 2. Model specification

## 3. R packages/functions

## 4. Data

## 5. Fit

## 6. Extract & interpret

## 7. Diagnostics

## 8. Caveats

## 9. Source references
````

### 3.4 Analysis-chapter content rules

#### Aim

In two to four technical sentences, state:

- the scientific or statistical estimand;
- the model class;
- the independent sampling unit;
- the data structure;
- when the method is appropriate.

#### Model specification

Use mathematical notation to define:

- response and cluster indices;
- conditional or marginal mean;
- link function;
- covariance, correlation, random-effects, or estimating-equation structure;
- distributional assumptions;
- relevant independence assumptions;
- the inferential target.

Do not present code before defining the model it implements.

#### Packages and functions

Explain why each selected function is idiomatic for the task. When the course source uses other software:

- identify the underlying model or procedure;
- implement the same statistical functionality in the target language;
- state differences in defaults, parameterization, estimation, inference, or output.

Examples of differences that require explicit treatment include:

- ML versus REML defaults;
- denominator-degree-of-freedom methods;
- availability of fixed-effect p-values;
- variance-component boundary tests;
- working-correlation and scale estimation;
- robust versus model-based covariance labels;
- quadrature or pseudo-likelihood defaults;
- covariance-structure parameterizations;
- contrast coding.

#### Data

Use a small built-in or openly downloadable dataset that:

- has the required repeated, clustered, multilevel, or multivariate structure;
- can be loaded without a private path;
- permits the entire chapter to render in a clean environment.

State the observational unit, cluster ID, time variable, outcome, major covariates, and ordering requirements. Create a reproducible simulated example only when no suitable public dataset exists. Set and report the random seed.

#### Fit

Provide complete runnable code for all major analyses supported by the topic map. Include:

- explicit data ordering and factor reference levels;
- centering/scaling decisions;
- formulas and covariance/random-effect structures;
- estimation method;
- model comparisons only when statistically valid;
- named objects reused in later extraction and diagnostics;
- comments explaining non-obvious implementation choices.

Avoid huge outputs, opaque convenience wrappers, and code that only works in an interactive session.

#### Extract and interpret

Show how to extract and report:

- estimands and transformations;
- fixed effects and uncertainty;
- variance or association parameters;
- contrasts and interaction contrasts;
- random-effect predictions when applicable;
- robust and model-based standard errors when applicable;
- fit criteria and test statistics;
- predictions on the correct scale.

Interpret each commonly reported quantity in one concise technical sentence. Always state the scale and conditioning set. Distinguish, where relevant:

- population-average versus subject-specific effects;
- conditional versus marginal predictions;
- within-subject versus between-subject effects;
- response-history conditional effects;
- link-scale versus response-scale effects;
- association parameters versus causal effects.

#### Diagnostics

Use model-specific checks rather than a generic checklist. Cover as applicable:

- residual versus fitted patterns;
- marginal, conditional, Pearson, deviance, or simulation-based residuals;
- residual correlation or variograms;
- normality and heteroscedasticity;
- random-effect diagnostics and the limitations of BLUP QQ plots;
- cluster-level influence and deletion diagnostics;
- overdispersion and zero inflation;
- singularity, gradients, Hessians, optimizer messages, and scaling;
- working-correlation sensitivity;
- weight distributions and positivity;
- multiple-imputation convergence and between-imputation behavior;
- train/test separation for prediction.

Diagnostics must be performed at the independent-cluster level when that is the sampling unit.

#### Caveats

State concise, model-specific traps. Include:

- assumptions needed for estimation and inference;
- estimands that change under alternative models;
- invalid likelihood comparisons;
- boundary or nonstandard null distributions;
- small-sample limitations;
- software-default differences;
- missing-data assumptions;
- causal-interpretation limitations;
- unsupported or unavailable functionality;
- a final label distinguishing source-backed content from standard-practice additions.

Use language such as:

```markdown
- **Source-backed:** <CONTENT SUPPORTED BY COURSE MATERIALS>.
- **Standard-practice addition:** <IDIOMATIC IMPLEMENTATION OR DIAGNOSTIC ADDED BY THE AUTHORS>.
```

#### Source references

Use concise, public-safe citations:

- lecture slide deck: `` `<PDF_BASENAME>.pdf`, slides <N--M> (<TOPIC>) ``;
- non-slide PDF: `` `<PDF_BASENAME>.pdf`, document pp. <N--M> (<TOPIC>) ``;
- course assignment: `<COURSE_CODE> Homework <N> (<TOPIC>)`;
- external course materials: `<EXTERNAL_COURSE_LABEL> (<TOPIC>)`;
- named supplementary note: `` `<PDF_BASENAME>.pdf`, document pp. <N--M> ``.

Never include:

- an absolute directory;
- a username or home directory;
- an assignment solution filename when the homework number suffices;
- external-course filenames when the authorized attribution is only the course label;
- personal filename prefixes such as `[Important]`, `[Annotated]`, or `[My copy]`.

Retain only the original/public PDF basename. If the local copy was renamed, recover the original name from metadata, course listings, or internal title pages.

If an authorized, stable public URL exists for a lecture deck, link the displayed PDF basename to that URL. If the slides are private, access-controlled, copyrighted course materials, or unavailable at a stable URL, cite the basename and slide range without uploading or exposing the local file.

## Phase 4: produce the mathematical companions

### 4.1 Purpose and separation from code

The mathematical writeups explain the models implemented by the analysis chapters. They must be independently readable and must not duplicate long code blocks. Their primary content is:

- motivation and estimand;
- mathematical formulation;
- assumptions;
- estimation;
- inference;
- interpretation;
- when to apply the model;
- source traceability;
- external verification.

One math topic may link to several code chapters, and one code chapter may link to several math topics.

### 4.2 Shared mathematical notation

Define a common notation in `math-writeups/00-index.qmd`. For clustered or longitudinal data, a useful generic convention is:

```math
i=1,\ldots,N,\qquad j=1,\ldots,n_i,
```

```math
Y_i=(Y_{i1},\ldots,Y_{in_i})^\mathsf T,\qquad
\mu_i=E(Y_i\mid X_i),\qquad
V_i=\operatorname{Var}(Y_i\mid X_i).
```

Define each parameter class once and specialize it by chapter. State that independent clusters, not rows, are the asymptotic sampling units unless the model says otherwise.

### 4.3 Exact math-writeup opening

Each math file must begin with:

```markdown
---
title: "<NUMBER>. <MATHEMATICAL TOPIC>"
format: html
---

**Slides covered.** `<DECK_A>.pdf`, slides <N--M>; `<SUPPLEMENT>.pdf`, document pp. <N--M>.
```

The opening source list identifies every course document materially used in the chapter.

### 4.4 Math-writeup organization

Use topic-appropriate headings, normally including:

1. Motivation
2. Problem formulation or estimand
3. Model and assumptions
4. Important special cases
5. Estimation
6. Inference
7. Interpretation
8. When to apply
9. External cross-check

Do not force empty sections. Merge closely related headings when that improves logical flow.

For every model, define:

- observed data and indexing;
- conditional and/or marginal distribution;
- mean and link;
- covariance or dependence;
- parameter space;
- independence or exogeneity assumptions;
- missingness assumptions when relevant;
- likelihood, estimating equation, or objective;
- variance estimator;
- test statistic and its reference distribution;
- interpretation of coefficients and variance/association parameters;
- conditions under which competing formulations have different estimands.

### 4.5 Source note after each key result

Attach a concise note to each key formula, result, or interpretation:

```markdown
*Slide source: `<LECTURE_DECK>.pdf`, slides <N--M>.*
```

For a non-slide document:

```markdown
*Document source: `<SUPPLEMENT>.pdf`, document pp. <N--M>.*
```

Citation numbering rules:

- `slide N` means the number visibly printed on the slide, normally in the lower-left corner;
- it is not the PDF viewer's page index;
- this convention remains stable across clean and annotated copies;
- `document p. N` is used only when no printed slide number exists;
- if numbering is missing or ambiguous, say so rather than inventing a slide number.

When a proof is present but intentionally omitted, write:

```markdown
Proof omitted; see `<LECTURE_DECK>.pdf`, slides <N--M>.
```

### 4.6 Mathematical writing style

Use mathematical and statistical language rather than conversational exposition.

- Introduce concepts progressively.
- Define notation before use.
- State the estimand before the estimator.
- State assumptions before inferential conclusions.
- Distinguish equality, approximation, convergence, and proportionality.
- Distinguish a likelihood from a quasi-likelihood or estimating equation.
- Distinguish model-based and sandwich covariance.
- Distinguish an association from a causal effect.
- Distinguish latent random effects from observed subject coefficients.
- State the scale of every interpretation.
- Use concise prose between equations.
- Avoid redundant restatement of displayed equations.
- Do not give elementary textbook definitions unless needed for precision.

For Quarto QMD:

- use `$...$` for inline mathematics;
- use `$$...$$` for displayed mathematics;
- never put LaTeX mathematics inside code spans;
- balance every delimiter and brace;
- use standard commands supported by MathJax;
- do not use manual line breaks solely for word wrapping.

### 4.7 External verification

After the initial source-based draft, independently check:

- model formulation and assumptions;
- likelihood or estimating equation;
- covariance formulas;
- ML/REML rules;
- boundary-test distributions;
- small-sample inference;
- robust variance formulas;
- missing-data ignorability;
- numerical integration or approximation claims;
- software defaults and package restrictions.

Use this priority:

1. seminal or primary methodological paper;
2. authoritative textbook or monograph;
3. official package documentation or vignette;
4. official software documentation.

Do not use unsourced blogs as the sole authority for technical claims. Add an **External cross-check** section with direct links to the sources actually used. If the course source and external authority differ, retain the course notation where possible and explain the substantive discrepancy.

Do not copy long passages from lecture slides or publications. Paraphrase and cite.

## Phase 5: build reciprocal navigation

### 5.1 Code-to-math links

At the top of every analysis and reference chapter, add a Quarto callout linking to all relevant math writeups:

```markdown
::: {.callout-note title="Mathematical companions"}
[<MATH TOPIC 1>](../math-writeups/<FILE_1>.qmd) · [<MATH TOPIC 2>](../math-writeups/<FILE_2>.qmd)
:::
```

### 5.2 Math-to-code links

In `math-writeups/00-index.qmd`, create a topic table:

| Mathematical writeup | Main content | Code companions |
|---|---|---|
| `[<MATH TOPIC>](<MATH_FILE>.qmd)` | `<ESTIMANDS/MODELS>` | `[<CODE TOPIC>](../analysis-in-r/<CODE_FILE>.qmd)` |

Also include:

- citation convention;
- shared notation;
- model-selection or estimand decision guide when supported;
- external cross-check overview.

### 5.3 Landing-page catalogue

Use `index.qmd` as a thin wrapper:

```markdown
{{< include 00-INDEX.md >}}
```

In `00-INDEX.md` include:

- project title;
- course provenance, e.g. “I took **<COURSE_CODE>: <COURSE_TITLE>** in <TERM>; its materials form the main backbone of this repository”;
- rendering note;
- **Analysis in `<PROGRAMMING_LANGUAGE>`** section;
- one linked entry and compact coverage list per code chapter;
- **Accompanying Mathematics** section;
- **Reference** section;
- enough information to find any model in one glance.

## Phase 6: produce previous-exam solutions from the manual

### 6.1 Preserve exam fidelity

For each year:

1. read the full exam PDF;
2. inspect every supplied dataset and codebook;
3. preserve the exam's question and subquestion order;
4. identify the requested estimand before choosing a model;
5. map each analysis to one or more manual topic identifiers;
6. use the manual's code patterns, extraction conventions, diagnostics, and interpretations;
7. use exam-specific data only in the exam solution;
8. flag absent or unusable source files;
9. do not fabricate a missing exam year.

Do not mechanically force the manual's model onto an exam question. If the scientifically appropriate method is outside the manual, use it and label it as an exam-specific extension.

### 6.2 Exam-solution README

Create `exam-solutions/README.md` containing:

- purpose of the solutions;
- link to the manual index;
- list of available years;
- explicit list of missing years;
- topic identifier table;
- explanation of the bridge file;
- rendering instructions;
- warning that generated cache and figure directories are not source files.

### 6.3 Shared manual bridge

Create `_manual_bridge.R` that:

- starts from the currently rendered solution file;
- walks upward until it finds `<MANUAL_DIR>/_common.R`;
- sets `manual_dir` and repository root dynamically;
- sources `_common.R`;
- sets the knitr root directory;
- records the stable topic identifier map;
- centralizes compact helper functions reused by exam solutions;
- never contains an absolute path.

If exam reporting needs different contrast coding from the manual, change it explicitly after sourcing `_common.R` and explain why.

### 6.4 Manual markers in every analysis block

Immediately before each substantive exam analysis block, include:

```markdown
> **Curated manual code:** [`<TOPIC_ID>`](<RELATIVE_LINK_TO_MANUAL_QMD>); [`<SECOND_TOPIC_ID>`](<RELATIVE_LINK_TO_SECOND_QMD>).
```

For an extension:

```markdown
> **Curated manual code:** [`<NEAREST_TOPIC_ID>`](<RELATIVE_LINK>). Exam-specific extension beyond the manual.
```

This marker must identify the manual chapter whose preparation, fitting, extraction, interpretation, or diagnostic pattern is being reused.

### 6.5 Exam-solution structure

Each solution should contain:

- YAML metadata and reproducible chunk options;
- setup sourcing `_manual_bridge.R`;
- data inventory and codebook mapping;
- a curated manual topic map;
- one section per exam question;
- equations for each fitted model;
- compact runnable code;
- direct numerical extraction;
- concise interpretation tied to the question;
- diagnostics and sensitivity analysis;
- reproducibility/caveat section;
- session information when useful.

For each requested analysis:

1. state the estimand;
2. state the fitted model mathematically;
3. show data preparation;
4. fit the model;
5. extract requested estimates, intervals, tests, or predictions;
6. interpret on the requested scale;
7. diagnose assumptions;
8. discuss missingness, selection, transportability, or causal limitations as applicable;
9. distinguish confirmatory analysis from exploratory alternatives.

Use shared helpers for consistent tables and contrasts, but keep the statistical calculations transparent.

## Phase 7: configure Quarto

Create `_quarto.yml` with:

```yaml
project:
  type: website
  output-dir: _site
  execute-dir: project
  render:
    - "*.qmd"
    - "analysis-in-r/*.qmd"
    - "math-writeups/*.qmd"
    - "references/*.qmd"

website:
  title: "<SITE_TITLE>"
  site-url: "<SITE_URL>"
  search: true
  sidebar:
    style: docked
    collapse-level: 1
    contents:
      - text: "Topic catalogue"
        href: index.qmd
      - section: "Analysis in <PROGRAMMING_LANGUAGE>"
        contents:
          - analysis-in-r/01-<topic>.qmd
          - analysis-in-r/02-<topic>.qmd
      - section: "Accompanying Mathematics"
        contents:
          - math-writeups/00-index.qmd
          - math-writeups/01-<topic>.qmd
      - section: "Reference"
        contents:
          - references/A1-<topic>.qmd
          - references/A2-<topic>.qmd
          - references/A3-packages.qmd

format:
  html:
    toc: true
    number-sections: false
    code-fold: false
    df-print: paged

execute:
  freeze: false
  warning: false
  message: false
```

Enumerate every actual chapter explicitly in the sidebar. Ensure paths are relative to `_quarto.yml`.

## Phase 8: configure Git and GitHub Pages

### 8.1 `.gitignore`

At minimum, ignore:

```gitignore
# Quarto-generated state and website output
/.quarto/
/_freeze/
/_site/

# Knitr/Quarto intermediates and caches
*.utf8.md
*.knit.md
**/*.quarto_ipynb
**/*_cache/
**/*_files/

# OS and IDE files
.DS_Store
Thumbs.db
.vscode/
.idea/
.Rproj.user/
*.Rproj

# R session files
.Rhistory
.Rapp.history
.RData

# Secrets
.env
.Renviron
credentials.json
```

Add language-appropriate cache and environment patterns. Do not ignore source QMD/Rmd files, `_quarto.yml`, `_common.R`, the workflow, or math writeups.

If generated output was previously tracked, remove it from the git index without deleting the local copy, then verify with `git check-ignore`.

### 8.2 GitHub Actions workflow

Create `.github/workflows/publish.yml` that:

1. triggers on pushes to `<DEFAULT_BRANCH>` and manual dispatch;
2. checks out the repository;
3. installs the required programming-language runtime;
4. installs Quarto;
5. installs every package required for a clean render;
6. renders the website;
7. configures GitHub Pages;
8. uploads `_site`;
9. deploys with the official GitHub Pages action;
10. grants only `contents: read`, `pages: write`, and `id-token: write`.

Derive the CI package list from:

- `_common.R`;
- unguarded `library()` or `require()` calls;
- unguarded `package::function()` usage;
- document-rendering requirements.

Optional guarded packages need not be installed unless their output is required for the published site. Prefer installing them when the corresponding examples are important to the finished book.

Set repository **Settings → Pages → Source** to **GitHub Actions**. The generated `_site` directory must remain ignored on the source branch; the workflow publishes it as an artifact.

## Phase 9: verification and quality control

Do not claim completion until every gate below passes.

### 9.1 Source and coverage checks

- Every source file is inventoried.
- Every primary lecture topic is mapped.
- Every included model has at least one math writeup and one code companion, unless explicitly identified as theory-only or code-only.
- Every math file lists all lecture sources it uses.
- Every key mathematical result has a nearby source note.
- Every exam analysis block has a manual-topic marker or an extension marker.
- Missing exam years or missing source files are documented.

### 9.2 Mathematical audit

For every formula:

- verify dimensions;
- verify conditioning and expectation notation;
- verify covariance and independence assumptions;
- verify parameterization and link;
- verify likelihood/estimating equation;
- verify standard-error formula;
- verify the reference distribution and boundary conditions;
- verify the interpretation scale;
- verify missing-data assumptions;
- compare against at least one authoritative external source for central results.

Resolve contradictions explicitly. Never “average” two incompatible formulas.

### 9.3 Code audit

- Start a clean session.
- Source `_common.R`.
- Run each analysis chapter from top to bottom.
- Render each exam solution with its actual same-year data.
- Confirm factor levels, ordering, offsets, cluster IDs, time variables, and missing values.
- Confirm model comparisons use compatible likelihoods and nestedness assumptions.
- Confirm optional-package branches behave correctly.
- Confirm stochastic results have fixed seeds.
- Confirm diagnostics use the correct sampling unit.
- Confirm reported interpretations agree with the fitted parameterization.

### 9.4 Quarto and LaTeX audit

Inspect every `.qmd`:

- balanced YAML delimiters;
- balanced code fences;
- balanced inline `$...$` delimiters;
- balanced display `$$...$$` delimiters;
- balanced braces in LaTeX;
- no LaTeX math inside code spans;
- no malformed subscripts, superscripts, matrices, cases, or alignment environments;
- no raw absolute paths;
- no broken relative links.

Then run the full project render. Inspect representative rendered pages from:

- the landing page;
- one code-heavy chapter;
- one math-heavy chapter;
- one reference chapter.

Confirm equations display through MathJax, code executes, tables fit, callouts link correctly, and sidebar order is correct.

### 9.5 Privacy and portability audit

Search all source and rendered files for:

- home-directory paths;
- usernames;
- drive letters;
- private network paths;
- API keys or credentials;
- personal filename prefixes;
- local annotation labels.

The expected result is zero. PDF citations must use basenames only. Course assignments must be attributed at the homework level. External course material must use only the approved course label when filenames should not be public.

### 9.6 Git audit

Before committing:

- run a whitespace/error check such as `git diff --check`;
- confirm `_site`, `.quarto`, freeze output, caches, and figures are ignored;
- review all staged filenames;
- ensure source materials were not modified;
- ensure no generated exam cache is staged;
- ensure the workflow and all QMD sources are staged;
- record the successful render result in the handoff.

Commit only after verification. Do not push unless the user authorizes it.

## Phase 10: working and communication rules

- Begin with read-only inspection.
- Make reasonable, reversible assumptions that preserve the requested scope.
- Ask only when a missing choice would materially change the repository.
- Give concise progress updates during long work.
- Do not report success based only on file creation; verify rendering and execution.
- Preserve unrelated user changes.
- Keep source-backed claims separate from independent derivations.
- If source coverage is incomplete, state the limitation.
- Prefer small, reviewable edits and stable filenames.
- Parallelize source inventory or independent topic audits only after the common notation, templates, and topic map are fixed.
- Keep a final checklist of completed chapters, missing items, verification results, and publication steps.

## Required completion report

At completion, report:

1. repository structure created or updated;
2. analysis chapters and reference chapters;
3. mathematical companions;
4. previous-exam solution years;
5. source-to-topic and code-to-math links;
6. external verification sources;
7. package/runtime requirements;
8. render results and number of pages;
9. math/LaTeX audit results;
10. privacy/path audit results;
11. git status and commit identifier, if committed;
12. exact remaining publication step, if pushing was not authorized;
13. any unresolved mathematical or source-coverage issues.

The work is complete only when a reader can move in both directions:

```text
lecture result
    ↕
mathematical formulation
    ↕
reproducible analysis code
    ↕
worked exam application
```

and every link, model, computation, interpretation, and public citation is reproducible from a clean checkout.

---

## Optional project-specific coverage block

Append a course-specific checklist here before giving the prompt to an agent. Use only topics actually covered by `<COURSE_CODE>`.

```text
Required topic/model:
- <TOPIC 1>
- <TOPIC 2>
- <TOPIC 3>

Required software equivalences:
- <SOURCE PROCEDURE> → <TARGET PACKAGE/FUNCTION>

Required interpretation distinctions:
- <DISTINCTION 1>
- <DISTINCTION 2>

Required exam years:
- <YEAR RANGE OR LIST>

Known missing materials:
- <MISSING ITEM OR "NONE">
```
