#' Load Binary 'rodeo' Model From File
#'
#' Load a model from class 'rodeo' or a derived class from a binary .rda file.
#' This requires that the corresponding class definition is already available
#' in the work space.
#'
#' @param  file full file name of the .rda object
#'
#' @export
#'
load_model <- function(file) {
  id <- load(file)
  ## field must contain only one single object
  if (length(id) !=1)
    stop("load_model expects a single object in the file")

  ## return the object with the name returned by load
  obj <- get(id)

  ## check if loaded object has correct class
  if (!inherits(obj, "rodeo")) warning("loaded object is not a rodeo model")

  return(obj)
}
