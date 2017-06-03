using Distributions


# Use Monte Carlo methods to estimate the divergences between two
# theoretical distributions. Take random samples of source distribution.
# Estimate cost at those points and weight by probability.

function mc_divergence_estimate(d1::Distribution, d2::Distribution, samples::Integer, sample_divergence_func::Function)
    divergence = 0.0
    for i in 1:samples
        x = rand(d1)
        divergence += sample_divergence_func(pdf(d1, x), pdf(d2, x))
    end
    return divergence
end

kl_divergence(d1::Distribution, d2::Distribution) = mc_divergence_estimate(d1, d2, 10_000, kl_sample_divergence)
skl_divergence(d1::Distribution, d2::Distribution) = mc_divergence_estimate(d1, d2, 10_000, skl_sample_divergence)
js_divergence(d1::Distribution, d2::Distribution) = mc_divergence_estimate(d1, d2, 10_000, js_sample_divergence)


