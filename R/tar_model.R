model <- tar_plan(
  tar_map(
    values = list(name = c("main", "model")),
    names = name,
    tar_file_read(
      jl,
      here_rel("Julia", paste0(name, ".jl")),
      readLines(!!.x)
    )
  ),
  res_model = run_model(jl_file_main, jl_main, jl_model),
  tar_file_read(
    parameters,
    res_model[[1]],
    yaml::read_yaml(!!.x)
  ),
  tar_file_read(
    demand_supply,
    res_model[[2]],
    read.csv(!!.x)
  ),
  tar_file_read(
    equilibrium,
    res_model[[3]],
    yaml::read_yaml(!!.x)
  )
)

run_model <- function(jl_file_main, ...) {
  system2(command = "julia", args = c("--project=.", jl_file_main))

  return(file.path(
    here_rel("output", "Julia"),
    c("parameters.yaml", "demand_supply.csv", "equilibrium.yaml")
  ))
}
