using Distributions

# Use Monte Carlo methods to estimate the Kullback-Leibler-Divergence or
# Jensen-Shannon-Divergence between two
# theoretical distributions. Take random samples of source distribution.
# Estimate cost at those points and weight by probability.

function kl_divergence_sample_prob(p_d1,p_d2)
    return -p_d1 * log(p_d2 / p_d1)
end

function js_divergence_sample_prob(p_d1, p_d2)
    p_m = (p_d1 + p_d2) / 2
    return (kl.kl_divergence_single(p_d1, p_m) + kl.kl_divergence_single(p_d2, p_m)) / 2
end

function divergence(d1::Distribution, d2::Distribution, samples::Integer, sample_divergence_func)
    divergence = 0.0
    for i in 1:samples
        x = rand(d1)
        divergence += sample_divergence_func(pdf(d1, x), pdf(d2, x))
    end
    return divergence
end

kl_divergence(d1::Distribution, d2::Distribution) = kl_divergence(d1, d2, 10_000, kl_divergence_sample_prob)
js_divergence(d1::Distribution, d2::Distribution) = kl_divergence(d1, d2, 10_000, js_divergence_sample_prob)


