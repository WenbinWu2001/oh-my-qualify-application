options(
  width = 100,
  contrasts = c("contr.sum", "contr.poly")
)

set.seed(767)

required_packages <- c(
  "dplyr", "tidyr", "ggplot2", "nlme", "lme4", "broom"
)
missing_required <- required_packages[
  !vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)
]
if (length(missing_required)) {
  stop(
    "Install required packages before rendering: ",
    paste(missing_required, collapse = ", "),
    call. = FALSE
  )
}

theme_set <- ggplot2::theme_set(
  ggplot2::theme_bw(base_size = 11) +
    ggplot2::theme(legend.position = "bottom")
)

icc_random_intercept <- function(model) {
  vc <- as.data.frame(lme4::VarCorr(model))
  tau2 <- vc$vcov[vc$grp != "Residual" & vc$var1 == "(Intercept)" & is.na(vc$var2)][1]
  sigma2 <- vc$vcov[vc$grp == "Residual"][1]
  unname(tau2 / (tau2 + sigma2))
}

gee_covariance_table <- function(model) {
  stopifnot(inherits(model, "geeglm"))
  data.frame(
    term = names(stats::coef(model)),
    estimate = unname(stats::coef(model)),
    model_based_se = sqrt(diag(model$geese$vbeta.naiv)),
    robust_se = sqrt(diag(model$geese$vbeta)),
    row.names = NULL
  )
}

mi_pool_scalar <- function(estimates, variances) {
  m <- length(estimates)
  qbar <- mean(estimates)
  ubar <- mean(variances)
  b <- stats::var(estimates)
  total <- ubar + (1 + 1 / m) * b
  data.frame(estimate = qbar, within = ubar, between = b, total = total, se = sqrt(total))
}
