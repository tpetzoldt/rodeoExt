#' Methos of Class \code{rodeoExt}
#'
#' Methods to handle reference class objects of class \code{rodeoExt}
#'
#'
#' @name rodeoExt-methods
#' @rdname rodeoExt-class
#'
#'
#' @seealso \code{\link{ode}}, \code{\link{lsoda}}, \code{\link{rodeo-class}}, \code{\link{rodeoExt-class}}
#'

# rodeoExt$methods(
#   nbox = function() {
#     "Returns the number of grid cells of 1D model objects or 1 for 0D (integer)."
#     if (is.null(grid) | length(grid) == 1) {
#       n <- 1
#     } else {
#       n <- nrow(grid)
#     }
#     n
#   }
# )
#


# Compile Fortran library for use with numerical methods from packages
# \\code{\\link[deSolve]{deSolve}} or \\code{\\link[rootSolve]{rootSolve}}.
rodeoExt$set("public", "compile", function() {
  src <- paste(self$folder, self$sources, sep = "/")
  super$compile(sources = src)
})

# Save model objecs as .rda file and corresponding .dll /. so
rodeoExt$set("public", "save",
             function(newname=self$modname, dll=TRUE, overwrite = FALSE) {

               tmp.modname <- newname

               rdafile <- paste0(self$folder, "/", tmp.modname, ".rda")
               if (!file.exists(rdafile) | overwrite) {
                 base::save(self, file = rdafile)
                 ##base::saveRDS(.self, file=rdsfile)
               } else {
                 warning(rdafile, "exists and is not overwritten")
               }
               if (dll) {
                 if (!file.exists(self$dllfile) | overwrite) {
                   folder <- paste0(gsub("[\\]", "/", tempdir()), "/")
                   file.copy(paste0(folder, model$libName(), .Platform$dynlib.ext), model$dllfile, overwrite = TRUE)
                 } else {
                   warning(self$dllfile, " exists and is not overwritten")
                 }
               }
               invisible(NULL)
             }
)

# Load the DLL (or shared object) of the model.
rodeoExt$set("public", "dyn.load",
  function() {
    ## thpe: improve compatibility between Unixes and Windows
    ## (use .dll/.so of the target system, irrespective where it comes from)
    dllfile <- self$dllfile
    ext <- substr(.Platform$dynlib.ext, 2, nchar(.Platform$dynlib.ext))
    dllfile <- sub("so$|dll$", ext, dllfile)
    base::dyn.load(dllfile)
  }
)

# Unload the DLL (or shared object) of the model.
rodeoExt$set("public", "dyn.unload",
  function() {
    dllfile <- self$dllfile
    ext <- substr(.Platform$dynlib.ext, 2, nchar(.Platform$dynlib.ext))
    dllfile <- sub("so$|dll$", ext, dllfile)
    base::dyn.unload(dllfile)
  }
)

# Activate the default parameter set from the rodeo 'pars' table.
rodeoExt$set("public", "setDefaultPars",
  function() {
    pp <- as.numeric(self$getParsTable()$default)
    names(pp) <- self$getParsTable()$name
    self$setPars(pp)
  }
)

# Activate the initial values from the rodeo 'vars table' table.
rodeoExt$set("public", "setDefaultVars",
  function() {
    y0 <- as.numeric(self$getVarsTable()$default)
    names(y0) <- self$getVarsTable()$name
    self$setVars(y0)
  }
)

# Simulate the model with function \\code{\\link{ode()}}.
rodeoExt$set("public", "sim",
  function(times, fortran=TRUE, proNames=TRUE, useRodeoDynamics=FALSE, ...) {
    if (useRodeoDynamics) {
      self$out <- self$dynamics(times=times, fortran=fortran, proNames=proNames, ...)
    } else {
      ## alternative: direct call to ode
      #cat("size=", self$lenPros()*prod(self$getDim()), "\n")

      #self$out <- deSolve::ode(
      #  y       = self$getVars(),
      #  times   = times,
      #  func    = self$libFunc(),
      #  parms   = self$getPars(),
      #  dllname = self$modname, # todo: make it a function
      #  #initfunc = "initmod", # now same as dllname (default)
      #  nout    = self$lenPros()*prod(self$getDim()),
      #  ...
      #)
      self$out <- deSolve::ode(y=self$getVars(),
                          parms=self$getPars(),
                          times=times,
                          func=self$libFunc(),
                          #dllname=self$libName(),
                          dllname = self$modname,
                          initfunc = self$libName(), # !! fix this
                          nout=self$lenPros()*prod(self$getDim()),
                          #outnames=if (proNames) elNames(self$namesPros(),self$getDim()) else NULL,
                          ...
      )
    }
  }
)

## helper function
stripDotSection <- function(x) {
  sub("[.].*$", "", x)
}

rodeoExt$set("public", "getOut",
  function(section = TRUE) {
    out <- self$out
    if (! section) {
      attr(out, "dimnames")[[2]] <- stripDotSection(attr(out, "dimnames")[[2]])
    }
    out
  }
)

rodeoExt$set("public", "getPars",
  function(asArray=FALSE, section=TRUE) {
    p <- super$getPars(asArray=asArray)
    if (!(section | asArray)) {
      names(p) <- stripDotSection(names(p))
    }
    p
  }
)

rodeoExt$set("public", "getVars",
  function(asArray=FALSE, section=TRUE) {
    v <- super$getVars(asArray=asArray)
    if (!(section | asArray)) {
      names(v) <- stripDotSection(names(v))
    }
    v
  }
)



