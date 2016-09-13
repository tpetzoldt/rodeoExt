#' Read Model from Excel File and Return Text Representation
#'
#' @param xlfile valid excel file with rodeo model description
#' @param sheets names of the spreadsheets imported
#'
#' @return list of data frames
#'
#' @export
#'
#'
read_xlmodel <- function (xlfile,
                          sheets = c("vars", "pars", "funs", "pros", "stoi")) {

  ## alternative: read all tables from excel file
  #sheets <- excel_sheets(xlfile)

  ## read the tables
  tables <- lapply(sheets, function(sheet) read_excel(xlfile, sheet = sheet))

  ## remove rows for which identifier (=1st column) contains NA
  tables <- lapply(tables, function(sheet) sheet[!is.na(sheet[,1]), ])

  names(tables) <- sheets

  ## reformat stoichiometry as cross table
  #tables$xstoi <- dcast(tables$stoi, process ~ variable, value.var="expression", fill="0")

  tables
}
