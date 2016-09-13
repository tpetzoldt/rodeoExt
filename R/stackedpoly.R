#' Plot Stacked and Filled Polygons
#'
#' Plot time series as stacked polygons with color fill and/or shading.
#'
#' @param x object of class \code{data.frame}, the first column is used as x-axis.
#' @param columns vector of column names in appropriate order that are plotted
#' @param density the density of shading lines, in lines per inch.
#'   The default value of NULL means that no shading lines are drawn.
#'   A zero value of density means no shading nor filling whereas negative
#'   values and NA suppress shading (and so allow color filling).
#' @param angle the slope of shading lines, given as an angle in degrees
#'   (counter-clockwise).
#' @param border border of the polygon
#' @param col the color for filling the polygon. The default, NA, is to
#'   leave polygons unfilled, unless density is specified. (For back-compatibility,
#'   NULL is equivalent to NA.) If density is specified with a positive value
#'   this gives the color of the shading lines.
#' @param xlab label of the x axis
#' @param ylab label of the y axis
#' @param ... further arguments passed to the \code{\link{polygon}}.
#'
#' @seealso \code{\link{plot.default}}, \code{\link{polygon}}
#'
#' @examples
#'
#' ## test data
#' set.seed(135)
#' dat <- data.frame(time = seq(7, 365, 14),
#'                   y1 = runif(26, min=1, max=10),
#'                   y2 = runif(26, min=0, max=15),
#'                   y3 = runif(26, min=0, max=2)
#' )
#'
#'
#' ##' example palette
#' palette <-c("grey", "brown", "green", "yellow", "yellowgreen",
#'             "darkgreen", "blue", "black", "red", "grey", "red", "orange",
#'             "pink", "cyan"
#' )
#'
#'
#' ## usage
#' stackedpoly(dat, c("y1", "y2", "y3"), col=palette)
#'
#' ## polygons with border
#' stackedpoly(dat, c("y1", "y2", "y3"), col=palette, border="black")
#'
#' ## optional plotting parameters
#' stackedpoly(dat, c("y1", "y2", "y3"), col=palette, ylim=c(0,50), main="Phytoplankton")
#'
#' ## changed order
#' stackedpoly(dat, c("y3", "y2", "y1"), col=palette, main="Phytoplankton")
#'
#' ## hatched area
#' stackedpoly(dat, c("y3", "y2", "y1"), density=c(20, 20, 40),
#'             angle=c(0, 90, 45), ylim=c(0,50), border=palette, main="Phytoplankton")
#'
#' @export
#'
stackedpoly <- function(x, columns, density = NA, angle = 45,
        border = NA, col = NA,  xlab = "x values", ylab = "y values", ...) {

  ## apply recycling rule to make all vectors of equal length
  m <- length(columns)
  density <- array(density, m)
  angle   <- array(angle, m)
  border  <- array(border, m)
  col     <- array(col, m)

  ## create x-data
  x1   <- x[[1]]
  xx <-  c(x1[1], x1, x1[length(x1)], x1[1])

  ## calculate y totals
  ysum <- rowSums(x[columns]) # sum of all selected rows

  ## draw empty plot
  plot(range(x1), range(0, ysum), type = "n", xlab = xlab, ylab = ylab, ...)
  ## draw polygons
  for (i in 1:m) {
    yy <- c(0,   ysum, 0      , 0)
    polygon(xx, yy, col = col[i], density = density[i],
      angle = angle[i], border = border[i], ...)
    ysum <- ysum - x[[columns[i]]]
  }
}
