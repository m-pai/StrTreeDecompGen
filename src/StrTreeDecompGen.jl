module StrTreeDecompGen 

using Catlab
using Catlab.Graphs
using Catlab.CategoricalAlgebra

using Graphs
using Combinatorics
using IterTools.Iterators

using .Decompositions

include("tree-gen.jl")
include("graph-gen.jl")
include("product.jl")
include("decomp.jl")

end