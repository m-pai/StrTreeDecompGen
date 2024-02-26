# Program to generate all reflexive symmetric graphs under a given node size.

using Catlab
using Graphs
using Combinatorics

"""
With this program, the aim is to generate the bags and apices for the structured decompositions. We do this with recursion, by adding an extra vertex to a graph on (n - 1) vertices and then connecting that vertex to all possible subsets of the graph, to get an array of possible graphs.
"""

"""
Function 'add_neighbour' takes a graph and a subset of vertices within the graph, and returns a graph with an extra vertex adjacent to all vertices of the subset.
"""

function add_neighbour(graph, subset)
    Graphs.add_vertex!(graph)
    for i in subset 
        Graphs.add_edge!(graph, i, Graphs.nv(graph))
    end
    return graph
end

"""
Function 'grow' takes a graph and returns an array of graphs each of which has an extra vertex connected to a different subset of the input graph.
"""

function grow(graph)
    arr = map(s -> add_neighbour(f[1:Graphs.nv(g)], s), Combinatorics. powerset(1:Int(Graphs.nv(graph))))

    return arr
end

"""
Function 'graphsof' takes a node size and uses the above functions to return an array of all graphs of that node size.
"""

function graphsof(node_size)
    arr = []

    if n == 0 
        push!(arr, Graphs.Graph(0))
        return arr
    else
        for i in graphsof(node_size-1)
            for j in grow(i)
                push!(arr, j)
            end
        end

        return arr
    end
end

"""
Function 'graphsupto' takes a node size (n) and returns all graphs on (n) or fewer vertices.
"""

function graphsupto(node_size)
    arr = []

    while n>-1
        for j in graphsupto(n)
            push!(arr, j)
        end
        node_size = node_size-1
    end

    return arr
end

"""
Function 'symref_conv' takes a node size n and returns all symmetric reflexive graphs on n or fewer vertices.
"""

function symref_conv(node_size)
    arr = map(i -> Catlab.Graphs.BasicGraphs.SymmetricReflexiveGraph(i), graphsupto(n))
    
    return arr
end