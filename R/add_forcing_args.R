#' Add Default Argument to Forcing Function Calls
#'
#' This function edits calls to time dependent forcing functions, e.g. 'foo(time)'
#'   to contain an additional parameter for defaults, e.g. 'foo(time, const_foo)',
#'   so that forcing functions can be handled as constant parameters, e.g. for model
#'   coupling in 'stop-and-go' mode.
#'
#' @param expr character vector of model expressions (processes or stoichiometry)
#' @param forc character vector or forcing functions for which an additional
#'   argument is to be inserted
#' @param prefix prefix preceeding the generated argument name
#'
#' @return vector of modified model expressions
#' @export
#'
add_forcing_args <- function(expr, forc, prefix="forc_") {

  tmp <- gsub("[ ]", "", expr) ## remove alls spaces

  add_forcing_arg <- function(f, s) {
    pattern <- paste0(f, "(time)")
    replace <- paste0(f, "(time, ", prefix, f,")")
    gsub(pattern, replace, s, fixed = TRUE)
  }

  for (i in 1:length(forc)) {
    tmp <- add_forcing_arg(forc[i], tmp)
  }
  tmp
}



