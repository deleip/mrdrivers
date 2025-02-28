% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/readJames.R
\name{readJames}
\alias{readJames}
\alias{convertJames}
\title{Read James}
\usage{
readJames(subtype)

convertJames(x, subtype)
}
\arguments{
\item{subtype}{String indicating the data series}

\item{x}{MAgPIE object returned by readJames}
}
\value{
GDP per capita in USD05 in PPP or MER as magpie object
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}

Read-in GDP per-capita data from the publication James, Spencer L., Paul
Gubbins, Christopher JL Murray, and Emmanuela Gakidou. 2012. "Developing a
Comprehensive Time Series of GDP per Capita for 210 Countries from 1950 to
2015." Population Health Metrics 10 (1): 12. doi:10.1186/1478-7954-10-12.
from a .csv file to a magclass object
}
\section{Functions}{
\itemize{
\item \code{convertJames}: convert function
}}

\examples{
\dontrun{ 
readSource("James", subtype = "IHME_USD05_PPP_pc")}
}
\seealso{
\code{\link[madrat:readSource]{madrat::readSource()}}
}
\keyword{internal}
