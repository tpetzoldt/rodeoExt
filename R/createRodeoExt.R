
#' Create an Extended 'rodeo' Model Object
#'
#' Create a model object from tabular data and save additional information.
#'
#' @param folder the folder where the model tables are located in
#' @param modfile the file with the model tables
#' @param forcings table with forcing functions
#' @param sources additional Fortran source files
#' @param modname name of the model
#'
#' @return an object of class \code{rodeoExt}
#'
#' @export
#'
createRodeoExt <- function(folder, modfile, forcings, sources, modname) {

  forc <- read_excel(paste0(folder, forcings), sheet="forc")
  forc$default <- rep(TRUE, nrow(forc))

  tables <- rodeo_tables(paste0(folder, modfile),
                         type="Excel",
                         sheets = c("vars", "pars", "funs", "pros", "stoi"))

  model <- with(tables,
    rodeoExt$new(vars=vars, pars=pars, funs=funs, pros=pros, stoi=stoi))

  ## write forcing function file
  fforc <- forcingFunctions(forc)
  write(fforc, file= paste0(folder, "/", sources["fforc"]))

  ## add additional fields to object
  model$folder  <- folder
  model$sources <- sources
  model$modname <- modname
  model$dllfile <- paste0(folder, modname, .Platform$dynlib.ext)

  return(model)
}

