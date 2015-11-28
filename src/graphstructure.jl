# graphstructure.jl
# Authors : Heitor Guimaraes and Luiz Ciafrino
#
#

type simpleGraph
"""
@brief: This composite type is an abstraction of a simple undirected
	graph. It is constructed through a text file contain details about it's
	edges and vertices. To a specific use in search algorithms as BFS and DFS
	you can use a method to transform this abstraction in a more concrete
	data structure as Adjacency List or Adjacency Matrix.
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
	@brief: Constructor of the composite type simpleGraph. This method
		read the text file and construct the Graph as a List with integer
		numbers. Also extract basic information about the graph to make
		a report if the user ask for it.
	@param filename::ASCIIString Name or path of the file contain the graph
		information. This function expect an ASCIIString.
	"""	
		# Instantiate the Class
		this = new()

		# Read the text file and get direct information.
		graphtxt = readdlm(filename)
		this.num_vertex = graphtxt[1]
		this.Graph = graphtxt[2:end, :]

		# Calculate the others information
		this.num_edge = size(this.Graph)[1]
		adjlist = graphtheoryufrj.asAdjList(this)

		#= Calculate the mean degree of the graph and
		store the distance for empirical distance =#
		sum = 0
		this.empirical_dist = zeros(Float64, this.num_edge - 1)
		@inbounds for i in 1:this.num_edge
			degree = length(adjlist[i])
			sum = sum + degree
			this.empirical_dist[degree] += 1 
		end
		this.mean_degree = (sum/this.num_edge)
		this.empirical_dist /= this.num_vertex

		this.make_report = function(outfilename::ASCIIString)
		"""
		@brief: Method to make a small report with usefull informations
			about the graph.
		@param outfilename String with the name of the report filename
			in the ASCIIString format. 
		"""
			# Open the file and write the information on it.
			outfile = open(outfilename, "w")
			write(outfile, string("# n = ", this.num_vertex,"\n"))
			write(outfile, string("# m = ", this.num_edge,"\n"))
			write(outfile, string("# d_medio = ", this.mean_degree,"\n"))

			for i in 1:length(this.empirical_dist)
				write(outfile, string(i, " ", this.empirical_dist[i], "\n"))
			end

			# Close and save the file.
			close(outfile)
		end
		return this
	end
end

#@TODO : Implement a class to generate graph examples.
type demoGraph
	function demoGraph()
		println("Inside the Class Demo Graph")
	end
end

function asAdjList(G::simpleGraph)
"""
@brief: Function to take the graph abstraction and transform into an 
	Adjacency List.
@param G::simpleGraph A simple graph containing the relations between
	the edges (vertices index).
@output: This function return the Adjacency List (Which is a List of List) for
	the given simpleGraph.
"""
	edges = G.num_edge
	adjlist = Array{Array{Int64}}(edges)

	# Initialize the List
	@inbounds @simd for i in 1:edges
	  	@inbounds adjlist[i]=Array{Int64}(0)
	end

	#
	@inbounds for i in 1:edges
    	id, vert = G.Graph[i,:]
    	push!(adjlist[id], vert)
    	push!(adjlist[vert], id)
    end

	@inbounds @simd for i in 1:edges
	  	@inbounds adjlist[i] = sort(adjlist[i])
	end    

	return adjlist
end

function asAdjMatrix(G::simpleGraph)
"""
@brief: Function to take the graph abstraction and transform into an 
	Adjacency Matrix.
@param G::simpleGraph A simple graph containing the relations between
	the edges (vertices index). 
@output: This function return the Adjacency Matrix (Which is a simple Matrix of
	0's and 1's) for the given simpleGraph.
"""
	vertex = G.num_vertex
	edges = G.num_edge
	adjmatrix = zeros(Int64, vertex, vertex)

	@inbounds @simd for i in 1:edges
    	rnum, cnum = G.Graph[i,:]
    	adjmatrix[rnum,cnum] = 1
    	adjmatrix[cnum,rnum] = 1
    end
	return adjmatrix
end

function asAdjVector(G::simpleGraph)
"""
@brief: Function to take the graph abstraction and transform into an 
	Adjacency Vector.
@param G::simpleGraph A simple graph containing the relations between
	the edges (vertices index). 
@output: This function return the Adjacency Vector (Which is ...)
	for the given simpleGraph.
"""

end