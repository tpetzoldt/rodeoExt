#'
#'
#' Extensions to the 'rodeo' Package
#'
#'  The package 'rodeo' (R ODE Objects) defines an 'R6' class
#'  to work with ordinary and partial differential equation models in
#'  stoichiometry notation and to generate computational efficient
#'  Fortran code. The aim of this package is to extend this class with
#'  additional information and to provide convenience functions to make
#'  working with 'rodeo' models easier.
#'
#'
#' @name rodeoExt-package
#' @aliases rodeoExt-package
#' @docType package
#' @author Thomas Petzoldt
#'
#' @seealso package \code{\link[rodeo:rodeo-package]{rodeo}}
#' for the code generator package.
#'
#' @seealso package \code{\link[deSolve:deSolve-package]{deSolve}}
#' for the numerical differential equation solverS.
#'
#'
#' @references
#'
#' Kneis, D. (2016). rodeo: A Code Generator for ODE-Based Models.
#' R package version 0.3.1.
#'
#' Soetaert, K. and Petzoldt, T. 2010. Inverse Modelling, Sensitivity
#' and Monte Carlo Analysis in R Using Package FME.  Journal of
#' Statistical Software, 33(3), 1-28.  URL
#' \url{http://www.jstatsoft.org/v33/i03/}
#'
#' Soetaert, K., Petzoldt, T. Setzer, R. W. 2010. Solving Differential
#' Equations in R: Package deSolve. Journal of Statistical Software,
#' 33(9), 1-25.  URL \url{http://www.jstatsoft.org/v33/i09/}
#'
#'
#' @keywords package
#'
#' //useDynLib lemon
#'
#' @import stats graphics R6 FME lattice deSolve readxl parallel
#' @importFrom utils type.convert read.csv2 read.table
#' @import rodeo reshape2
#'
NULL
