using Distributions

# Use Monte Carlo methods to estimate the KL-Divergence between two
# theoretical distributions. Take random samples of source distribution.
# Estimate cost at those points and weight by probability.
function kl_divergence(d1::Distribution, d2::Distribution, samples::Integer)
    divergence = 0.0
    for i in 1:samples
        x = rand(d1)
        divergence += -pdf(d1, x) * log(pdf(d2, x) / pdf(d1, x))
    end
    return divergence
end

kl_divergence(d1::Distribution, d2::Distribution) = kl_divergence(d1, d2, 10_000)
