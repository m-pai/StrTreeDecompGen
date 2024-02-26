include("Decompositions.jl")
using Catlab.CategoricalAlgebra

include("01-tree-gen.jl")
include("02-graph-gen.jl")
include("03-product.jl")
include("04-decomp.jl")
include("05-codecomp.jl")

"""
The solution function gives the apex of limit of all decompositions for all trees of a given size.
"""

function solution(tree_size, bag_size, decomp_type)
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