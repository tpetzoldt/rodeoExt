#' Read 'rodeo' Model from Excel or CSV Files and Return Text Representation
#'
#' @param folder valid folder name or excel file with rodeo model description
#' @param sheets names of the spreadsheets imported
#' @param type type of the data format
#' @param ext file extension of text and csv files
#' @param ... other arguments passed to the file read function, e.g. to
#' \code{\link{read_excel}} or \code{\link{read.csv2}}
#'
#' @return list of data frames
#'
#' @details The tables must follow the rodeo specification and contain valid column headers.
#'
#' @export
#'
#'
rodeo_tables <- function (folder,
                               sheets = c("vars", "pars", "funs", "pros", "stoi"),
                               type = c("Excel", "csv2"), ext = NA, ...) {

  ## alternative: read all tables from excel file
  #sheets <- excel_sheets(xlfile)

  ## read the tables
  if (type == "Excel") {
    tables <- lapply(sheets, function(sheet)
      read_excel(folder, sheet = sheet))
  } else if (type == "csv2") {
    ext <- ifelse(is.na(ext), "csv", ext)
    ext <- sub("^[.]", "", ext) # strip leading "." from ext
    tables <- lapply(sheets, function(sheet)
      read.csv2(paste0(folder, "/", sheet, ".", ext), header=TRUE, ...))
  } else {
    stop("unknown type")
  }

  ## remove rows for which identifier (=1st column) contains NA
  tables <- lapply(tables, function(sheet) sheet[!is.na(sheet[,1]), ])

  names(tables) <- sheets

  ## reformat stoichiometry as cross table
  #tables$xstoi <- dcast(tables$stoi, process ~ variable, value.var="expression", fill="0")

  tables
}
