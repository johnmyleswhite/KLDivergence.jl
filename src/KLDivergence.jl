module KLDivergence
	export kl_divergence, kl_sample_divergence, skl_divergence, skl_sample_divergence, js_divergence, js_sample_divergence, mc_divergence_estimate, categorical_divergence_estimate

    include("sample_divergence.jl")
	include("mc.jl")
    include("categorical.jl")
end
