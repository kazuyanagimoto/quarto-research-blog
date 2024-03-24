library(ggplot2)
library(showtext)
library(patchwork)

font_base_regular <- "Roboto Condensed"
font_base_light <- "Roboto Condensed Light"

# font_add_google(font_base_regular, font_base_light)
showtext_auto()

# Theme

theme_notebook <- function(font_title = font_base_regular,
                           font_text = font_base_light,
                           size_base = 30) {

  ggplot2::theme_minimal(base_family = font_text, base_size = size_base) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(size = size_base * 1.2, face = "bold",
                                          family = font_title),
      plot.subtitle = ggplot2::element_text(size = size_base, face = "plain",
                                              family = font_text),
      plot.caption = ggplot2::element_text(size = size_base * 0.8,
                                          color = "grey50",
                                          face = "plain",
                                          family = font_text,
                                          margin = ggplot2::margin(t = 10)),
      panel.grid.minor = ggplot2::element_blank(),
      strip.text = ggplot2::element_text(size = size_base * 0.9, hjust = 0,
                                          family = font_text, face = "bold"),
      strip.background = ggplot2::element_rect(fill = "#ffffff", color = NA),
      axis.ticks = ggplot2::element_blank(),
      axis.title = ggplot2::element_text(family = font_text, face = "plain",
                                          size = size_base * 0.8),
      axis.title.x = ggplot2::element_text(margin = ggplot2::margin(t = 5)),
      axis.text = ggplot2::element_text(family = font_text, face = "plain"),
      legend.title = ggplot2::element_blank(),
      legend.key = ggplot2::element_blank(),
      legend.text = ggplot2::element_text(size = size_base * 0.75,
                                          family = font_text, face = "plain"),
      legend.spacing = ggplot2::unit(0.1, "lines"),
      legend.box.margin = ggplot2::margin(t = -0.5, unit = "lines"),
      legend.margin = ggplot2::margin(t = 0),
      legend.position = "bottom",
      plot.title.position = "plot"
    )
}

# Color
color_base <- "#009F8C"
color_base_light <- "#95DFD6"
color_accent <- "#B75C9D"
color_accent_light <- "#DBA6CC"

## Okabe-Ito Color Maps
cm <- c("#E69F00", "#56B4E9", "#009E73", "#F5C710", "#0072B2", "#D55E00",
        "#CC79A7", "#999999", "#000000")

cm <- c(color_base, color_accent, cm[3:9])

scale_color_discrete <- function(...) {
  scale_color_manual(values = cm, ...)
}
scale_fill_discrete <- function(...) {
  scale_fill_manual(values = cm, ...)
}

scale_color_gender <- function(...) {
  scale_color_manual(values = c(color_base, color_accent), ...)
}
scale_fill_gender <- function(...) {
  scale_fill_manual(values = c(color_base, color_accent), ...)
}

# Scale
scientific_10 <- function(x) {
  xx <- dplyr::case_when(
    x>=-100 & x<=100 ~ as.character(x),
    x>100 & log10(x)%%1==0 ~ gsub(".+e\\+", "10^", scales::scientific_format()(x)),
    TRUE ~ gsub("e\\+", " %*% 10^", scales::scientific_format()(x)))
  parse(text = xx)
}