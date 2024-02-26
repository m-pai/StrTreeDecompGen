# Program to generate all trees of a given node size.

using Graphs
using IterTools
using Catlab

"""
For our purpose, we use Prufer codes to generate trees.

A Prufer code is a unique way of representing a labelled tree. The algorithm to generate a Prufer code for a given tree is as follows:
1. For a tree with n nodes, find the leaf of the tree with the lowest label and make note of its adjacent vertex. Then, remove the leaf.
2. Perform step 1. n-2 times.

Unfortunately, because Prufer codes are for labelled trees, it cannot identify the difference between isomorphic trees that are labelled differently.
"""

"""
Function 'prufer_gen' generates Prufer codes. It does so by taking and node size n and generating (n-2)-tuples of set {1, 2, ..., n}. The function returns an array of Cartesian products.

The IterTools.jl module has a 'product' function that we use to generate this.
"""

function prufer_gen(node_size)
    arr = []

    for i in 1:node_size - 2 
        push!(arr, 1:node_size)
    end

    prod = collect(IterTools.Iterators.product(arr...))

    return prod
end

"""
Function 'tree_gen' takes a node size, and generates prufer_codes using the `prufer_gen` function and decodes them using the in-built `prufer_decode` function of the Graphs.jl module to generate trees. The function returns an array of trees of the given node size.
"""

function tree_gen(node_size)
    arr = []

    if node_size == 1
        push!(arr, Graphs.Graph(1))
    elseif node_size == 2
        push!(arr, Graphs.prufer_decode(Int64[]))
    else
        pruf_arr = prufer_gen(node_size)
        for i in pruf_arr
            push!(arr, Graphs.prufer_decode(collect(i)))
        end
    end

    return arr
end

"""
Because we are using the Catlab.jl module in future codes, we want to convert our trees of type Graphs.Graph to the type Catlab.Graphs.BasicGraphs.Graph. To do this, we write a function 'tree_conv' that takes in an array of trees, and returns a converted array.
"""

function tree_conv(tree_arr)
    conv_arr = map(i -> Catlab.Graphs.BasicGraphs.Graph(i), tree_arr)

    return conv_arr
end