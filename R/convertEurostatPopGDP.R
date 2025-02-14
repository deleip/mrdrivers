#' @rdname readEurostatPopGDP
#' @order 2
#' @param x MAgPIE object returned by readEurostatPopGDP
convertEurostatPopGDP <- function(x, subtype) {
  switch(
    subtype,
    "population"             = convEurostatPopulation(x),
    "population_projections" = convEurostatPopulation(x),
    "GDP"                    = convEurostatGDP(x),
    stop("Bad input for convertEurostat. Invalid 'subtype' argument.")
  )
}

convEurostatPopulation <- function(x) {
  # Fix names of sets, and of variable
  x <- collapseDim(x, dim = 3)
  getNames(x) <- "population"
  # Use the "DE_TOT" values for Germany, if they exist (DE_TOT = East + West Germany)
  x["DE", , ] <- if ("DE_TOT" %in% getItems(x, 1)) x["DE_TOT", , ] else x["DE", , ]
  # Drop any countries with more than 2 charachters in their Eurostat identifier. Those are aggregates.
  myCountries <- getItems(x, 1)[purrr::map_lgl(getItems(x, 1), ~ nchar(.x) == 2)]
  x <- x[myCountries, , ]
  # Convert the eurostat countrycodes to iso3c codes
  getItems(x, 1) <- countrycode::countrycode(getItems(x, 1), "eurostat", "iso3c", warn = FALSE)
  # ABOVE Warning: Some values were not matched unambiguously: FX, XK
  # Fix set names

  toolGeneralConvert(x, note = FALSE)
 }

convEurostatGDP <- function(x) {
  # Convert the eurostat countrycodes to iso3c codes
  getItems(x, 1) <- countrycode::countrycode(getItems(x, 1), "eurostat", "iso3c", warn = FALSE)
  # ABOVE warning that is being ignored:
  # Some values were not matched unambiguously: EA, EA12, EA19, EU15, EU27_2020, EU28

  x <- toolGeneralConvert(x, note = FALSE)

  # Convert from constant 2005 LCU to constant 2005 Int$PPP.
  getNames(x) <- "GDP"
  x <- GDPuc::convertGDP(x, "constant 2005 LCU", "constant 2005 Int$PPP", replace_NAs = c("linear", "no_conversion"))
}
