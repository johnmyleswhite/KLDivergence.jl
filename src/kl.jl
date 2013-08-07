using Distributions

# non-symmetric (i.e. conventional) divergence for a single sample

function kl_sample_divergence(dist1_probab,dist2_probab)
    return -dist1_probab * log(dist2_probab / dist1_probab)
end

# symmetrized divergence for a single sample

function skl_sample_divergence(dist1_probab,dist2_probab)
    return kl_sample_divergence(dist1_probab,dist2_probab) + kl_sample_divergence(dist2_probab,dist2_probab)
end

# Jensen-Shannon divergence for a single sample (symmetric)

function js_sample_divergence(dist1_probab, dist2_probab)
    const mean_probab = (dist1_probab + dist2_probab) / 2
    return (kl_sample_divergence(dist1_probab, mean_probab) + kl_sample_divergence(dist2_probab, mean_probab)) / 2
end


# Use Monte Carlo methods to estimate the divergences between two
# theoretical distributions. Take random samples of source distribution.
# Estimate cost at those points and weight by probability.

function mc_divergence_estimate(d1::Distribution, d2::Distribution, samples::Integer, sample_divergence_func)
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


