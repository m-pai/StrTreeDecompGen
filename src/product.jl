# Program to find the Cartesian products of an array

using IterTools

"""
In our program to find decompositions, we will need an array of indices to point to lengths of epimorphisms. We produce that using a function 'prod' which takes in an array of numbers, and returns an array Cartesian products of the ranges of numbers in input array.
"""

function prod(array)
    arr = []

    for i in array
        push!(arr, (1:i))
    end

    arr2 = collect(IterTools.Iterators.product(arr...))
    return arr2
end