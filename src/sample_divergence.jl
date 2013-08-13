# non-symmetric (i.e. conventional) divergence for a single sample

function kl_sample_divergence(dist1_probab::Float64, dist2_probab::Float64)
    return -dist1_probab * log(dist2_probab / dist1_probab)
end

# symmetrized divergence for a single sample

function skl_sample_divergence(dist1_probab::Float64, dist2_probab::Float64)
    return kl_sample_divergence(dist1_probab,dist2_probab) + kl_sample_divergence(dist2_probab,dist2_probab)
end

# Jensen-Shannon divergence for a single sample (symmetric)

function js_sample_divergence(dist1_probab::Float64, dist2_probab::Float64)
    const mean_probab::Float64 = (dist1_probab + dist2_probab) / 2
    return (kl_sample_divergence(dist1_probab, mean_probab) + kl_sample_divergence(dist2_probab, mean_probab)) / 2
end