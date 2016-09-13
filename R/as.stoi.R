#' Convert Stoichiometry Tables
#'
#' Convert stoichiometry tables from data base to crosstable format and and
#' Vice-Versa.
#'
#' @param x crosstable resp. database table
#'
#' @return object of class stoi resp. xstoi
#'
#' @rdname as.stoi
#' @export
#'
as.xstoi <- function(x) {
  xstoi <- dcast(x, process ~ variable, value.var="expression", fill="0")
  attr(xstoi, "rodeo_xstoi")
  xstoi
}


#' @rdname as.stoi
#'
#' @export
#'
as.stoi <- function(x) {
  stoi <- melt(x, id.vars=1, measure.vars=2:ncol(x))[c("variable", "process", "value")]
  names(stoi)[3] <- "expression"
  stoi <- subset(stoi, expression != "0")
  attr(stoi, "rodeo_stoi")
  stoi
}
