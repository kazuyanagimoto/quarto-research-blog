using DataFrames, CSV
using YAML
using ProjectRoot

dir = @projectroot "playground/250413_aiyagari_model"

include("model.jl")
using .My

m = My.Model()
rᴰ_grid = range(0.0, 0.05, length=30)
rˢ_grid = range(-0.03, m.λ, length=30)
Kᴰ_grid = [My.Kᴰ(r; m) for r in rᴰ_grid]
Kˢ_grid = [My.Kˢ(r; m) for r in rˢ_grid]

df = DataFrame(
    label = vcat(fill("Demand", length(rᴰ_grid)), fill("Supply", length(rˢ_grid))),
    r = vcat(rᴰ_grid, rˢ_grid),
    K = vcat(Kᴰ_grid, Kˢ_grid),
)

CSV.write("$dir/demand_supply.csv", df)

# Equilibrium

r, K = My.solve_rk(m)
d = Dict("r" => r, "K" => K)
YAML.write_file("$dir/equilibrium.yaml", d)