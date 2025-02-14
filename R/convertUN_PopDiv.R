#' @rdname readUN_PopDiv
#' @order 2
#' @param x MAgPIE object returned from readUN_PopDiv
# Converts data from \code{readUN_PopDiv()} to ISO country level. "Other,
# non-specified areas" is used as a stand-in for Taiwan, Province of China.
# Countries missing in the data set are set to zero.
convertUN_PopDiv <- function(x, subtype = "WPP2019_estimates") { # nolint

  if (grepl("WPP2019", subtype)) {
    getCells(x) <- getCells(x) %>%
      countrycode::countrycode("un",
                               "iso3c",
                               custom_match = c("158" = "TWN", "830" = "GB_CHA"))
    # Add the Channel Islands (GB_CHA) to Great Britain (GBR)
    x["GBR", , ] <- x["GBR", , ] + x["GB_CHA", , ]
    x <- x["GB_CHA", , invert = TRUE]
    x <- toolGeneralConvert(x)

  } else if (subtype == "WPP2015") {
     targetIso3c <- suppressMessages(
       readr::read_csv2(system.file("extdata", "iso_country.csv", package = "madrat"),
                        col_names = c("country", "iso3c"),
                        col_types = "cc",
                        skip = 1)
     ) %>%
       getElement("iso3c")

     xHave <- x %>%
       as.data.frame() %>%
       dplyr::select(.data$Year, .data$Value, .data$Region) %>%
       # convert years to integers and
       # add iso3c country codes . Use "other, non-specified areas" as proxy for "Taiwan, Province of China"
       dplyr::mutate(year = as.integer(as.character(.data$Year)),
                     iso3c = countrycode::countrycode(.data$Region, "un", "iso3c", warn = FALSE),
                     iso3c = ifelse(.data$Region == "158", "TWN", .data$iso3c),
                     .keep = "unused") %>%
       # drop entries from non-countries
       dplyr::filter(!is.na(.data$iso3c))

     missingIso3c <- setdiff(targetIso3c, unique(xHave$iso3c))

     # notify about missing countries
     message("Population data for the following countries is not available and",
             "therefore set to 0:\n",
             paste(countrycode::countrycode(missingIso3c, "iso3c", "country.name"),
                   collapse = ", "))

     # fill missing countries with zeros
     xMissing <- expand.grid(year = unique(xHave$year),
                              iso3c = missingIso3c,
                              Value = 0)

     dplyr::bind_rows(xHave, xMissing) %>%
       dplyr::arrange(.data$year, .data$iso3c) %>%
       # convert from thousands to millions
       dplyr::mutate(Value = .data$Value / 1000) %>%
       # reorder columns because as.magpie() does not give a shit about its
       # parameters and assignes dimensions based on column position
       dplyr::select(.data$iso3c, .data$year, .data$Value) %>%
       as.magpie()
  }
}
