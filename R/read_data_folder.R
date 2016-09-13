#' Read All Data Files From a Folder
#'
#' Read all textfiles from a specified folder and return list with all data.
#'
#' @param path a character vector of full path names
#' @param pattern regular expression matching the file names
#' @param header boolean, if the first row of the data fioles is a
#' @param sep separator
#' @param ... further arguments passed to \code{\link{read.table}}
#'
#' @return list with all data
#'
#' @export
#'
read_data_folder <- function(path, pattern, header=TRUE, sep="\t", ...) {

  files <- list.files(path=path, pattern=pattern)
  ret <- lapply(files, function(f)
    read.table(paste0(path, f), header=header, sep=sep, ...))
  IDs <- sub("[.].*", "", files)
  names(ret) <- IDs
  ret
}


#inputs <- read_data_folder(path = "./data/forcings/", pattern=".*[.]csv$")
