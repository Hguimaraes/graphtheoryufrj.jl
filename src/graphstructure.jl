# graphstructure.jl
# Authors : Heitor Guimaraes and Luiz Ciafrino
# @brief: Module to handle basic graph manipulation

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
	Graph::Union{Array{Array{Int64},1}, Array{UInt8,2}}
	make_report::Function
	format_graph::ASCIIString

	function simpleGraph(filename::ASCIIString, format::ASCIIString = "adjlist")
	"""
	@brief: Constructor of the composite type simpleGraph. This method
		read the text file and construct the Graph as a List with integer
		numbers. Also extract basic information about the graph to make
		a report if the user ask for it.
	@param filename::ASCIIString Name or path of the file contain the graph
		information. This function expect an ASCIIString.
	@param format::ASCIIString Option for specify the type of representation
		for the graph. Options are: 'adjlist' or 'adjmatrix'.
	"""	
		# Instantiate the Class
		this = new()

		# Read the text file
		infile = open(filename)
		this.num_vertex = parse(Int64, readline(infile))

		lines = readlines(infile)
		this.num_edge = size(lines)[1]
		this.format_graph = format

		# Return the selected structure
		if format == "adjlist"
		"""
		@brief: With this flag you can take the graph abstraction and transform
			into an Adjacency List.
		"""
			# Pre-allocate the structure
			this.Graph = Array{Array{Int64}}(this.num_vertex)
			
			# Initialize with Zeros
			@inbounds @simd for i in 1:this.num_vertex
   	 			this.Graph[i] = Array{Int64}(0)
    		end

    		# Fill the Adjacency List
			@time @inbounds for i in lines
				vertex = parse(Int64,split(i)[1])
				edge = parse(Int64,split(i)[2])
				push!(this.Graph[vertex], edge)
				push!(this.Graph[edge], vertex)
			end

		elseif format == "adjmatrix"
		"""
		@brief: With this flag you can take the graph abstraction and transform
			into an Adjacency Matrix.
		"""
			# Pre-allocate the structure and initialize with zeros
			this.Graph = zeros(UInt8, this.num_vertex, this.num_vertex)
			@time @inbounds for i in lines
				rnum = parse(Int64,split(i)[1])
				cnum = parse(Int64,split(i)[2])
				this.Graph[rnum, cnum] = 1
				this.Graph[cnum, rnum] = 1
			end
		else
			error(""" Invalid format selected, options are:\n
				* adjlist\n
				* adjmatrix\n
				Example: graph = simpleGraph(\"mygraph.txt\", \"adjmatrix\")""")
		end
		
		this.make_report = function(outfilename::ASCIIString)
		"""
		@brief: Method to make a small report with usefull informations
			about the graph.
		@param outfilename String with the name of the report filename
			in the ASCIIString format. 
		"""
			# Get the mean degree and the empirical distance.
			mean_degree, empirical_dist = graph_properties(this)

			# Open the file and write the information on it.
			outfile = open(outfilename, "w")
			write(outfile, string("# n = ", this.num_vertex,"\n"))
			write(outfile, string("# m = ", this.num_edge,"\n"))
			write(outfile, string("# d_medio = ", mean_degree,"\n"))

			for i in 1:length(empirical_dist)
				if empirical_dist[i] != 0
					write(outfile, string(i, " ", empirical_dist[i], "\n"))
				end
			end

			# Close and save the file.
			close(outfile)
		end

		close(infile)
		return this
	end
end

#@TODO : Implement a class to generate graph examples.
type demoGraph
	function demoGraph()
		println("Inside the Class Demo Graph")
	end
end

function graph_properties(G::simpleGraph)
	#= Calculate the mean degree of the graph and
	store the distance for empirical distance =#
	empirical_dist = zeros(Float64, G.num_edge - 1)
	mean_degree = 0.0
	sum = 0

	for i in 1:G.num_vertex
		degree = (G.format_graph == "adjmatrix") ? +(G.Graph[:,i]...) : length(G.Graph[i])
		if degree != 0
			sum += degree
			empirical_dist[degree] += 1
		end	
	end
	
	mean_degree = (sum/G.num_edge)
	empirical_dist /= G.num_vertex
	return mean_degree, empirical_dist
end
