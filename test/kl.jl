using Distributions, KLDivergence

@assert kl_divergence(Normal(0, 1), Normal(0, 1)) == 0.0
@assert kl_divergence(Normal(0, 1), Normal(1, 1)) >
          kl_divergence(Normal(0, 1), Normal(0, 1))
@assert kl_divergence(Normal(0, 1), Normal(0, 3)) >
          kl_divergence(Normal(0, 1), Normal(0, 1))
