using .Decompositions
using Catlab.CategoricalAlgebra

include("tree-gen.jl")
include("graph-gen.jl")
include("product.jl")

function decompositions(tree, bag_size)
    decomp = []

    n = 2 * Catlab.Graphs.BasicGraphs.nv(tree) - 1

    e = elements(tree)
    el = ∫(e)

    for gs in Combinatorics.permutations(symref_conv(bag_size), n)

        ob_dict = Dict(zip(ob_generators(el),gs))

        all_epis = Any[]

        for f in hom_generators(el)
            push!(all_epis, filter!(t-> is_epic(t), homomorphisms(ob_dict[e[f, :src]], ob_dict[e[f, :tgt]])))
        end

        if !isempty(all_epis)
            lengths = map(length, all_epis)

            for i in prod(lengths)
                chosen_epis = map(l -> l[1][l[2]], zip(all_epis, i))

                mor_dict = Dict(zip(hom_generators(el), chosen_epis))

                F = FinDomFunctor(ob_dict, mor_dict, el)

                d = StrDecomp(tree, F, Decomposition)
                push!(decomp, d)
            end
        end
    end

    return decomp
end