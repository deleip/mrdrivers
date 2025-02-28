#' Download WDI
#'
#' Download World development indicators (WDI) data to .Rds file.
#' Data is downloaded from 1960 until "current year - 1".
#' The WDI data is updated with the function "WDISearch(cache = WDIcache())"
#'
#' @seealso <https://databank.worldbank.org/source/world-development-indicators>
#' @seealso [madrat::downloadSource()]
#' @seealso [readWDI()]
#'
#' @examples \dontrun{
#' library(mrdrivers)
#' downloadSource("WDI")
#' }
#'
downloadWDI <- function() {
  WDI::WDIsearch(cache = WDI::WDIcache())
  indicator <- c("SP.POP.TOTL",       # population, total
                 "NY.GDP.MKTP.PP.KD", # GDP ppp, constant 2017 int$
                 "NY.GDP.MKTP.PP.CD", # GDP current international $
                 "NY.GDP.MKTP.KD",    # GDP constant 2010 US$
                 "NY.GDP.MKTP.CD",    # GDP current US$
                 "NY.GDP.MKTP.KN",    # GDP constant LCU
                 "NY.GDP.MKTP.CN",    # GDP current lCU
                 "NY.GDP.DEFL.KD.ZG", # GDP deflator (annual%)"
                 "NV.AGR.TOTL.ZS",    # AFF value added (%of GDP)
                 "NV.AGR.TOTL.KD",    # AFF value added (constant 2010 US$)
                 "SP.URB.TOTL.IN.ZS", # Urban Population (% of total)
                 "AG.SRF.TOTL.K2",    # surface area, sq. km
                 "NY.GDP.PCAP.CN",    # GDP per capita current LCU,
                 "NY.GDP.PCAP.PP.KD", # GDP per capita PPP, 2017int$,
                 "NY.GDP.PCAP.KD",    # GDP per capita MER, 2010 US$,
                 "NV.AGR.TOTL.CD",    # Ag GDP MER, current US$,
                 "NV.AGR.TOTL.KD",    # Ag GDP MER, 2010 US$
                 "NY.GDP.PCAP.CD",    # GDP per capita, current US$
                 "NY.GDP.PCAP.PP.CD", # GDP per capita, current PPP int$
                 "PA.NUS.PPPC.RF"     # Price Level Ration (PPP/MER)
                 )
  endYear <- as.numeric(strsplit(as.character(Sys.Date()), "-")[[1]][1]) - 1
  wdi <- WDI::WDI(indicator = indicator, start = 1960, end = endYear)
  readr::write_rds(wdi, "WDI.Rds")

  # Compose meta data
  list(url           = "-",
       doi           = "-",
       title         = "Select indicators from the WDI",
       description   = "Select indicators from the World Development Indicators database from the World Bank",
       unit          = "-",
       author        = "World Bank",
       release_date  = "-",
       license       = "-",
       comment       = "-")
}
