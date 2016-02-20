function dsatur(G::Array{Array{Int64},1})
	l = length(G)
	vertex_color = zeros(Int,l)
	degrees = Array{Tuple{Int,Int}}(l)
	satur = zeros(Int,l)
	uncolored = Set(collect(1:l))
	color_counter = 1

	for i in 1:l
		degrees[i] = (length(G[i]), i)
	end

	#coloring max degree vertex

	max_deg_vertex = maximum(degrees)[2] 
	vertex_color[max_deg_vertex] = color_counter

	delete!(uncolored, max_deg_vertex)

	#Increase saturation of max_degree_vertex neighbours
	for j in G[max_deg_vertex]
		satur[j]+=1
	end

	# println("Initial status")
	# println("Degrees $degrees")
	# println("uncolored $uncolored")
	# println("satur $satur")
	# println("vertex color $vertex_color")
	# println("_______________________________________")
	
	coloring = 0
	while !isempty(uncolored)
		# println("uncolored $uncolored")
		# println("satur $satur")
		# println("vertex color $vertex_color")

		max_satur_degree_vertices = []
		aux = []
		for i in uncolored	
			push!(aux, (satur[i], i))
		end

		max_sat = findmax(aux)[1][1]
		for i in aux
			if i[1] == max_sat
				push!(max_satur_degree_vertices, i[2])
			end
		end

		# println("max satur vertices $max_satur_degree_vertices")
		coloring = max_satur_degree_vertices[1]

		if length(max_satur_degree_vertices) > 1 #if there are more than 1 vertex with max_satur, untie by max_degree
			max_degree = -1
			node_index = -1
			for i in max_satur_degree_vertices
				degree, node_index = degrees[i]
				if degree > max_degree
					coloring = node_index
					max_degree = degree
				end
			end
		end

		# println("coloring vertex $coloring")

		#Coloring
		for number_color in 1:color_counter
			if amount_color(G[coloring], number_color, vertex_color) == 0
				vertex_color[coloring] = number_color
				break
			end
		end

		#In case it wasnt colored
		if vertex_color[coloring] == 0
			color_counter+=1
			vertex_color[coloring] = color_counter
		end

		delete!(uncolored, coloring)
		# println("colored one more, uncolored $uncolored")
		# println("_______________________________________")

		for j in G[coloring]
			if amount_color(G[j], vertex_color[coloring], vertex_color) == 1
				satur[j] +=1
			end
		end
	end
	return vertex_color
end

function amount_color(node_indexes, color_number, vertex_color)
	color_counter = 0
	for i in node_indexes
		if vertex_color[i] == color_number
			color_counter +=1
		end
	end
	return color_counter
end




