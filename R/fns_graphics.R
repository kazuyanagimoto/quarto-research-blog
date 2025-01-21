theme_proj <- function(
  font_title = "Roboto Condensed",
  font_text = "Roboto Condensed Light",
  size_base = 20
) {
  ggplot2::theme_minimal(base_family = font_text, base_size = size_base) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(
        size = size_base * 1.1,
        face = "bold",
        family = font_title
      ),
      plot.subtitle = ggplot2::element_text(
        size = size_base,
        face = "plain",
        family = font_text
      ),
      plot.caption = ggplot2::element_text(
        size = size_base * 0.6,
        color = "grey50",
        face = "plain",
        family = font_text,
        margin = ggplot2::margin(t = 10)
      ),
      panel.grid.minor = ggplot2::element_blank(),
      strip.text = ggplot2::element_text(
        size = size_base * 0.9,
        hjust = 0,
        family = font_text,
        face = "bold"
      ),
      strip.background = ggplot2::element_rect(fill = "#ffffff", color = NA),
      axis.ticks = ggplot2::element_blank(),
      axis.title = ggplot2::element_text(
        family = font_text,
        face = "plain",
        size = size_base * 0.8
      ),
      axis.title.x = ggplot2::element_text(margin = ggplot2::margin(t = 5)),
      axis.text = ggplot2::element_text(family = font_text, face = "plain"),
      legend.title = ggplot2::element_blank(),
      legend.key = ggplot2::element_blank(),
      legend.text = ggplot2::element_text(
        size = size_base * 0.75,
        family = font_text,
        face = "plain"
      ),
      legend.spacing = ggplot2::unit(0.1, "lines"),
      legend.box.margin = ggplot2::margin(t = -0.5, unit = "lines"),
      legend.margin = ggplot2::margin(t = 0),
      legend.position = "bottom",
      plot.title.position = "plot"
    )
}

scale_fill_gender <- function(...) {
  scale_fill_manual(values = c("#009F8C", "#B75C9D"), ...)
}
