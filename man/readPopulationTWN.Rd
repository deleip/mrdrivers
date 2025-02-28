% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/readPopulationTWN.R
\name{readPopulationTWN}
\alias{readPopulationTWN}
\title{Read TWN Population projections.}
\usage{
readPopulationTWN(subtype)
}
\arguments{
\item{subtype}{A string. Variant of population projection.}
}
\value{
A magpie object of the TWN population data
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}

Read-in Population projections for Taiwan
}
\examples{
\dontrun{ 
library(mrdrivers)
readSource("PopulationTWN", subtype = "medium")}
}
\seealso{
\code{\link[madrat:readSource]{madrat::readSource()}}

Other "Future" population functions: 
\code{\link{readPEAP}()}
}
\concept{"Future" population functions}
\concept{PopulationTWN functions}
\keyword{internal}
