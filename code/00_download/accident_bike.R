library(here)
library(tidyverse)
library(arrow)

url_base <- "https://datos.madrid.es/egob/catalogo/300228-%s-accidentes-trafico-detalle.csv"

years <- 2019:2023
keys <- c(19, 21, 22, 24, 26) #URL becomes caos since 2020


for (dir in c(here("data/raw/accident_bike"),
              here("data/raw/accident_bike/txt"))) {
  if (!dir.exists(dir)) {
    dir.create(dir)
  }
}

for (i in seq_along(years)) {
  year <- years[i]
  key <- keys[i]

  url <- sprintf(url_base, key)
  dir_file <- here(sprintf("data/raw/accident_bike/txt/year=%s/", year))
  if (!dir.exists(dir_file)) {
    dir.create(dir_file)
    download.file(url, destfile = file.path(dir_file, "file.txt"))
  }
}


# Convert to parquet
## Since the file column type is not consistent, we cannot use arrow::open_dataset()
map(years, ~read_delim_arrow(here(sprintf("data/raw/accident_bike/txt/year=%s/file.txt", .x)),
                       delim = ";")) |>
  list_rbind() |>
  select(-starts_with("...")) |>
  write_parquet(here("data/raw/accident_bike/accident_bike.parquet"))