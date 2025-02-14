#' Read OECD GDP or PPP2MER ratio
#'
#' Read-in GDP or PPP2MER ratio data xlsx file from OECD as magclass object
#'
#' @param subtype data subtype. Either "gdp" or "ratioPM"
#' @return magpie object of the GDP data
#' @seealso [madrat::readSource()]
#' @examples \dontrun{
#' readSource("OECD", "gdp")
#' readSource("OECD", "ratioPM")
#' }
#' @order 1
readOECD <- function(subtype) {
  files <- c(gdp       = "OECD_v9_25-3-13-3.xlsx",
             ratioPM   = "OECD-WB_PPP-MER2005_conversion_rates.xlsx",
             riskClass = "cre-crc-current-english.xlsx")

  file <- toolSubtypeSelect(subtype, files)

  data <- as.data.frame(readxl::read_excel(file))

  if (subtype == "gdp") {
    data <- data[data$Variable == "GDP|PPP", ]
    data <- data[, c(-1, -4, -5)]  # should be done better?
    x <- as.magpie(data)
    getNames(x) <- paste("gdp_", gsub("_v[[:alnum:],[:punct:]]*", "", getNames(x)), sep = "")
  } else if (subtype == "ratioPM") {
    data <- data[, c(1, 2)]
    data[, 2] <- as.numeric(data[, 2])
    colnames(data) <- c("Region", "y2005") # automated?
    x <- as.magpie(data)
  } else if (subtype == "riskClass") {
    # delete data for Kosovo
    data <- data[-which(data$`Country Name (1)` == "Kosovo"), ]
    # delete not needed information
    data$`Country Name (1)`        <- NULL # nolint
    data$Notes                     <- NULL # nolint
    data$`Previous Classification` <- NULL # nolint
    # transform into numeric
    data$`Current Prevailing Classification` <- as.numeric(data$`Current Prevailing Classification`) # nolint
    # transfer into a magpie object
    x <- as.magpie(data)
    getSets(x)[1] <- "country"
  }

  x
}
