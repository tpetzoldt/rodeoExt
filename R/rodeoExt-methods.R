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
  path <- paste(self$folder, self$sources, sep = "/")
  self$lib <- super$compile(fileFun=path)
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
                   file.copy(self$lib["libFile"], self$dllfile, overwrite = overwrite)
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
    base::dyn.load(self$dllfile)
  }
)

# Unload the DLL (or shared object) of the model.
rodeoExt$set("public", "dyn.unload",
  function() {
    base::dyn.unload(self$dllfile)
  }
)

# Activate the default parameter set from the rodeo 'pars' table.
rodeoExt$set("public", "setDefaultPars",
  function() {
    pp <- as.numeric(self$getParsTable()$default)
    names(pp) <- self$getParsTable()$name
    self$assignPars(pp)
  }
)

# Activate the initial values from the rodeo 'vars table' table.
rodeoExt$set("public", "setDefaultVars",
  function() {
    y0 <- as.numeric(self$getVarsTable()$default)
    names(y0) <- self$getVarsTable()$name
    self$assignVars(y0)
  }
)

# Simulate the model with function \\code{\\link{ode()}}.
rodeoExt$set("public", "sim",
  function(times, ...) {
    self$out <-
      ode(
        y = self$queryVars(),
        times = times,
        func = "derivs_wrapped",
        parms = self$queryPars(),
        dllname = self$modname,
        initfunc = "initmod",
        nout = self$lenPros() * self$size(),
        ...
      )
  }
)

## helper function
stripDotSection <- function(x) {
  sub("[.].*$", "", x)
}

rodeoExt$set("public", "queryOut",
  function(section = TRUE) {
    out <- self$out
    if (! section) {
      attr(out, "dimnames")[[2]] <- stripDotSection(attr(out, "dimnames")[[2]])
    }
    out
  }
)

rodeoExt$set("public", "queryPars",
  function(asMatrix=FALSE, section=TRUE) {
    p <- super$queryPars(asMatrix=asMatrix)
    if (!(section | asMatrix)) {
      names(p) <- stripDotSection(names(p))
    }
    p
  }
)

rodeoExt$set("public", "queryVars",
  function(asMatrix=FALSE, section=TRUE) {
    v <- super$queryVars(asMatrix=asMatrix)
    if (!(section | asMatrix)) {
      names(v) <- stripDotSection(names(v))
    }
    v
  }
)



