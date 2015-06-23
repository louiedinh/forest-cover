# Simple logistic model on just elevation.

fit_logistic <- function(data) {
  glm(Cover_Type ~ Elevation, family="binomial")
}