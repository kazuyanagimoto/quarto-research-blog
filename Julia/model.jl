module My

using QuantEcon
using Roots

@kwdef struct Model{TI<:Integer, TF<:AbstractFloat}
    
    γ::TF = 3.
    β::TF = 0.96
    δ::TF = 0.08
    α::TF = 0.36
    b::TF = 3.0

    # AR(1)
    ρ::TF = 0.6
    σ::TF = 0.4

    # Grids
    n_l::TI = 7
    n_k::TI = 100
    k̄::TF = 20.0
    λ::TF = 1/β - 1

    # Labor Productivity
    mc::MarkovChain = tauchen(n_l, ρ, σ, 0., 2.)
    l_grid::Vector{TF} = exp.(mc.state_values)
    P::Matrix{TF} = mc.p
    L::TF = l_grid' * stationary_distributions(mc)[1]
end

function pfi(r; m::Model, tol = 1e-6, max_iter = 1000)

    (; γ, β, α, δ, b, n_l, n_k, P, l_grid) = m

    w = (1 - α) * (α / (r + δ))^(α / (1 - α))
    k̲ = r < zero(r) ? -b : -min(b, w * l_grid[begin] / r)
    k_grid = collect(range(k̲, m.k̄, length = n_k))
    i_g = zeros(Int, n_k, n_l)
    i_g′ = similar(i_g)
    V = zeros(n_k, n_l)
    V′ = similar(V)

    iter, dist = 0, Inf
    while (dist > tol) && (iter < max_iter)
        for (i_k, k) in enumerate(k_grid), (i_l, l) in enumerate(l_grid)
            V_opt, i_k′_opt = -Inf, 0
            for (i_k′, k′) in enumerate(k_grid)
                c = w * l + (1 + r) * k - k′
                if c < 0
                    break
                end

                V_temp = c^(1-γ) / (1-γ) + β * sum(
                    V[i_k′, i_l′] * P[i_l, i_l′] for i_l′ in eachindex(l_grid))
                
                if V_temp > V_opt
                    V_opt, i_k′_opt = V_temp, i_k′
                end

            end
            
            V′[i_k, i_l], i_g′[i_k, i_l] = V_opt, i_k′_opt
        end
        dist = maximum(abs, i_g .- i_g′)
        copy!(V, V′)
        copy!(i_g, i_g′)
        iter += 1
    end

    # Stationary distribution μ(k, l)
    μ = fill(1 / (n_k * n_l), n_k, n_l)
    iter, dist = 0, Inf
    while (dist > tol) && (iter < max_iter)
        μ′ = zeros(n_k, n_l)
        for i_k in eachindex(k_grid), i_l in eachindex(l_grid)
            i_k′ = i_g[i_k, i_l]
            for i_l′ in eachindex(l_grid)
                μ′[i_k′, i_l′] += P[i_l, i_l′] * μ[i_k, i_l]
            end
        end
        
        dist = maximum(abs, μ .- μ′)
        copy!(μ, μ′)
        iter += 1
    end

    K = sum(μ .* k_grid)
    g = [k_grid[i_g[i_k, i_l]] for i_k in eachindex(k_grid),
                                   i_l in eachindex(l_grid)]

    return K, g, k_grid
end

Kᴰ(r; m::Model) = m.L * (m.α / (r + m.δ))^(1/(1-m.α))
Kˢ(r; m::Model) = pfi(r; m)[1]

function solve_rk(m::Model)
    r = find_zero(r -> Kᴰ(r; m) - Kˢ(r; m), (0.0, m.λ))
    K = Kᴰ(r; m)
    return r, K
end

end # module
