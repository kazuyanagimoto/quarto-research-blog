library(targets)
library(tarchetypes)
suppressPackageStartupMessages(library(dplyr))

options(
  tidyverse.quiet = TRUE,
  dplyr.summarise.inform = FALSE,
  readr.show_col_types = FALSE
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

tar_plan(
  # Data Preparation ----------
  data,
  # Analysis ------------------
  fact,
  model,
  # Graphics ------------------
  fns_graphics = lst(theme_proj, color_base, color_accent, scale_fill_gender),
  # Manuscript ----------------
  tar_quarto(manuscript_book, path = "manuscript", quiet = FALSE),
  tar_quarto(manuscript, path = "manuscript/main.qmd", quiet = FALSE),
  # Website -------------------
  tar_quarto(
    website,
    path = ".",
    quiet = FALSE,
    extra_files = here_rel("manuscript", "main.pdf")
  )
)
