% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rodeoExt-class.R, R/rodeoExt-methods.R
\docType{data}
\name{rodeoExt-class}
\alias{rodeoExt}
\alias{rodeoExt-class}
\alias{rodeoExt-methods}
\title{R6 Class \code{rodeoExt}}
\format{An object of class \code{R6ClassGenerator} of length 24.}
\usage{
rodeoExt
}
\description{
The \code{rodeoExt} R6 class extends class \code{rodeo} to
allow encapsulation of ODE-based models together with additional
data and utilities for simulation control.

Methods to handle reference class objects of class \code{rodeoExt}
}
\section{Fields}{

\describe{
\item{\code{folder}}{working directory in which the model is run}

\item{\code{modname}}{name of the model used as the base for the created binary model file and the dll}

\item{\code{sources}}{additional Fortran source files needed to compile the model}

\item{\code{lib}}{internal vector of data returned during compilation of the model source code}

\item{\code{grid}}{discretization grid if the model is a 1D model}

\item{\code{activeVars}}{active initial state used for the simulation}

\item{\code{activePars}}{active parameter values}

\item{\code{out}}{simulation output}
}}
\seealso{
package \code{\link{rodeo-package}} for fields and methods inherited from package \code{rodeo}.

\code{\link{ode}}, \code{\link{lsoda}}, \code{\link{rodeo-class}}, \code{\link{rodeoExt-class}}
}
\keyword{datasets}

