library(targets)
library(tarchetypes)
suppressPackageStartupMessages(library(dplyr))

options(
  tidyverse.quiet = TRUE,
  dplyr.summarise.inform = FALSE
)

tar_option_set(
  packages = c("tidyverse"),
  format = "qs",
  workspace_on_error = TRUE,
  workspaces = c()
)

# here::here() returns an absolute path, which then gets stored in tar_meta and
# becomes computer-specific (i.e. /Users/andrew/Research/blah/thing.Rmd).
# There's no way to get a relative path directly out of here::here(), but
# fs::path_rel() works fine with it (see
# https://github.com/r-lib/here/issues/36#issuecomment-530894167)
here_rel <- function(...) {
  fs::path_rel(here::here(...))
}

tar_source()

#-------------------------------------------------------------------------------
# Main Pipeline
#-------------------------------------------------------------------------------

lst(
  # Data -----------------------------------------------------------------------
  tar_target(
    dir_raw_accident_bike,
    download_accident_bike(here_rel("data", "accident_bike")),
  ),
  tar_target(raw_accident_bike, load_accident_bike(dir_raw_accident_bike)),
  tar_target(accident_bike, clean_accident_bike(raw_accident_bike)),
  # Graphics -------------------------------------------------------------------
  tar_target(
    fns_graphics,
    lst(theme_proj, scale_fill_gender)
  ),
  # Website -----------------------------------------------------------------------
  tar_quarto(website, path = ".", quiet = FALSE)
)
