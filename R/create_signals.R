#' Create \code{approxfun} Signals from List of Dataframes
#'
#' Create a list of approxfun signals from a list of data frames with 2 columns
#' where the first column is taken as \code{x} and the second as \code{y}
#'
#' @param L list of data frames (currently with two columns only)
#' @param ... further arguments passed to \code{\link{approxfun}}
#'
#' //@return list of \code{\link{approxfun}}-functions (not yet implemented)
#'
#' @export
#'
create_signals <- function(L) {

  create_approxfun <- function(id, ...) {
    cmd <- paste0("fx_", id,
                  " <- approxfun(L[['",id,"']][,1], L[['",id,"']][,2])")
    eval(parse(text=cmd))
  }

  IDs <- names(L)
  listOfFuns <- lapply(IDs, create_approxfun)
  names(listOfFuns) <- IDs
  listOfFuns
}
