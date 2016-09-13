#' R6 Class \code{rodeoExt}
#'
#' The \code{rodeoExt} R6 class extends class \code{rodeo} to
#' allow encapsulation of ODE-based models together with additional
#' data and utilities for simulation control.
#'
#' @name rodeoExt-class
#' @name aliases rodeoExt-class
#'
#' @field folder working directory in which the model is run
#' @field modname name of the model used as the base for the created binary model file and the dll
#' @field sources additional Fortran source files needed to compile the model
#' @field lib internal vector of data returned during compilation of the model source code
#' @field grid discretization grid if the model is a 1D model
#' @field activeVars active initial state used for the simulation
#' @field activePars active parameter values
#' @field out simulation output
#'
#' @seealso package \code{\link{rodeo-package}} for fields and methods inherited from package \code{rodeo}.
#'
#' @export

rodeoExt <- R6Class("rodeoExt",
                    inherit = rodeo,
                    public = list(
                      folder = NULL,     # working directory of the model
                      modname = NULL,    # basename of .dll/.so and .rda files (without extension)
                      sources = NULL,    # additional Fortran 95 source files
                      dllfile = NULL,    # full name of .dll/.so with extension
                      lib = NULL,        # vector of files returned by compile
                      grid = NULL,       # grid; empty for 0D models, then nbox is set to 1
                      activeVars = NULL, # initial values
                      activePars = NULL, # parameter values that are set "active"
                      out = NULL         # simulation results
                    )
)
