#' Combine two deSolve Output Objects
#'
#' This function is a stub .... ToDo: error checking, "diagnostics"-method
#'
#' @param out1 first deSolve object
#' @param out2 second deSolve object
#'
#' @return combined ode object
#'
#' @export
#'
#
rbind.deSolve <- function(out1, out2) {
  class(out1) <- "matrix"
  class(out2) <- "matrix"
  out <- base::rbind(out1, out2)
  attr(out, "istate") <- NULL # attr(out2, "istate")
  attr(out, "rstate") <- NULL # attr(out2, "rstate")
  attr(out, "type")   <- "combined object" #attr(out2, "type")
  #if (attr(out1, "type") != (attr(out2, "type"))) warning("Type does not match")
  class(out) <- c("deSolve", "matrix")      # output of a differential equation

  ## reorder
  #ndx <- order(out[,1])
  #out[ndx,]
  out
}

#x <- rbind.deSolve(out, out)
