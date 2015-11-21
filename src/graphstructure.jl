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
	make_report::Function

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
		##this.mean_degree = ??
		##this.empirical_dist = ??

		this.make_report = function(outfilename::ASCIIString)
		"""
		"""
			# Open the file and write the information on it.
			outfile = open(outfilename, "w")
			write(outfile, string("# n = ", this.num_vertex,"\n"))
			write(outfile, string("# m = ", this.num_edge,"\n"))
			write(outfile, string("# d_medio = ", this.mean_degree,"\n"))

			# Close and save the file.
			close(outfile)
		end
		return this
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
@description:
@param G::simpleGraph :
@output:
"""
end

function asAdjMatrix(G::simpleGraph)
"""
@description:
@param G::simpleGraph :
@output:
"""
	vertex = simpleGraph.num_vertex
	edges = simpleGraph.num_edge
	adjmatrix = zeros(Int64, vertex, vertex)

	@inbounds @simd for i in 1:edges
    	rnum, cnum = simpleGraph.Graph[i,:]
    	adjmatrix[rnum,cnum] = 1
    end
	return adjmatrix
end