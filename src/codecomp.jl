using .Decompositions
using Catlab.CategoricalAlgebra

include("tree-gen.jl")
include("graph-gen.jl")
include("product.jl")

function codecompositions(tree, bag_size)
    codecomp = []

    n = 2 * Catlab.Graphs.BasicGraphs.nv(tree) - 1

    e = elements(tree)
    el = ∫(e)

    for gs in Combinatorics.permutations(symref_conv(bag_size), n)

        ob_dict = Dict(zip(ob_generators(el),gs))

        all_monos = Any[]

        for f in hom_generators(el)
            push!(all_monos, filter!(t-> is_monic(t), homomorphisms(ob_dict[e[f, :tgt]], ob_dict[e[f, :src]])))
        end

        if !isempty(all_monos)
            lengths = map(length, all_monos)

            for i in prod(lengths)
                chosen_monos = map(l -> l[1][l[2]], zip(all_monos, i))

                mor_dict = Dict(zip(hom_generators(el), chosen_monos))

                F = FinDomFunctor(ob_dict, mor_dict, el)

                d = StrDecomp(tree, F, CoDecomposition)
                push!(codecomp, d)
            end
        end
    end

    return codecomp
end