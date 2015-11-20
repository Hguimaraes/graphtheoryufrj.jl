#
#
#
#
#

using DataStructures

# Abstraction of a Graph structure. 
#Used to generate all of the other graphs.
abstract abstractGraph{V::Int64,E::Int64}

#
type Graph <: abstractGraph{V::Int64,E::Int64}
	filename::ASCIIString
	asAdjList::Function
	asAdjMatrix::Function
end

#
type demoGraph

end
