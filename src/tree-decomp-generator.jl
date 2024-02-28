using .Decompositions
using Catlab.CategoricalAlgebra

include("tree-gen.jl")
include("graph-gen.jl")
include("product.jl")
include("decomp.jl")
include("codecomp.jl")

"""
The solution function gives the apex of limit of all decompositions for all trees of a given size.
"""

function tree_decomp_gen(tree_size, bag_size, decomp_type)
  arr = []
  t = tree_conv(tree_size)
  if decomp_type == CoDecomposition
    for i in t 
        k = codecompositions(i, bag_size)
        for j in k
            push!(arr, j)
        end
    end
  else 
    for i in t 
        k = decompositions(i, bag_size)
        for j in k
            push!(arr, j)
        end
    end
  end
  return arr
end