#
#
#
#
#

using DataStructures

#
type simpleGraph
"""
"""
	# Properties of the Graph
	num_vertex::Int64
	num_edge::Int64
	mean_degree::Float64
	empirical_dist::Array{Float64,1}

	function simpleGraph(filename::ASCIIString)
	"""
	"""	
		println("Inside the Class Graph")
	end

	function make_report()
	"""
	"""

	end
end

#
type demoGraph
	function Graph()
		println("Inside the Class Demo Graph")
	end
end

function asAdjList(G::simpleGraph)
"""
"""
end

function asAdjMatrix(G::simpleGraph)
"""
"""	
end