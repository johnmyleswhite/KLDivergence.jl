using Distributions, KLDivergence

const div_func = [kl_divergence, skl_divergence, js_divergence]

for i in 1:length(div_func)
    try
        @assert div_func[i](Normal(0, 1), Normal(0, 1)) == 0.0
        @assert div_func[i](Normal(0, 1), Normal(1, 1)) >
                  div_func[i](Normal(0, 1), Normal(0, 1))
        @assert div_func[i](Normal(0, 1), Normal(0, 3)) >
                  div_func[i](Normal(0, 1), Normal(0, 1))
    catch e
        throw(string(e.msg, ", where div_func[i] == ", div_func[i]))
    end
end
