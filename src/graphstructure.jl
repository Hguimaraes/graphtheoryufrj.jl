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
	empirical_dist::Array{Float64, 1}
	Graph::Array{Int64, 2}

	function simpleGraph(filename::ASCIIString)
	"""
	"""	
		# Instantiate the Class
		this = new()

		# Read the text file and get direct information.
		graphtxt = readdlm(filename)
		this.num_vertex = graphtxt[1]
		this.Graph = graphtxt[2:end, :]

		# Calculate the others information
		this.num_edge = size(this.Graph)[1]
		#this.mean_degree = 
		#this.empirical_dist =

		return this
	end

	function make_report()
	"""
	"""
	end
end

#
type demoGraph
	function demoGraph()
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