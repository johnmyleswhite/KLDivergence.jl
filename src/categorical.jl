import Distributions.Categorical


# Calculate the divergences between two Categorical distributions.
# If the distributions have unequal number of categories or
# just too many categories, resort to Monte Carlo estimation.

function categorical_divergence_estimate(d1::Categorical, d2::Categorical, samples::Integer, sample_divergence_func::Function)
    println("test")
    if d1.K != d2.K || d1.K > samples
        # resort to sampling
        return mc_divergence_estimate(d1, d2, samples, sample_divergence_func)
    end
    
    divergence = 0.0
    for i in 1:d1.K
        divergence += sample_divergence_func(pdf(d1, i), pdf(d2, i))
    end
    return divergence
end

kl_divergence(d1::Categorical, d2::Categorical) = categorical_divergence_estimate(d1, d2, 10_000, kl_sample_divergence)
skl_divergence(d1::Categorical, d2::Categorical) = categorical_divergence_estimate(d1, d2, 10_000, skl_sample_divergence)
js_divergence(d1::Categorical, d2::Categorical) = categorical_divergence_estimate(d1, d2, 10_000, js_sample_divergence)


