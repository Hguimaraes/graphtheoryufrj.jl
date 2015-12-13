using graphtheoryufrj

"""
Requirement (PT-BR): Compare o desempenho em termos de quantidade de memoria
utilizada pelas duas representacoes do grafo. Ou seja, determine a quantidade
de memoria (em MB) utilizada pelo seu programa quando voce representa o grafo
utilizando uma matriz de adjacencia e lista de adjacencia.
"""
function test_one(infile_name::ASCIIString)
	println("- Starting the Test One")
	try
		println("\n-- Time to fill as Adjacency List:\n")
		@time graph_list = simpleGraph(infile_name)

		println("\n-- Time to fill as Adjacency Matrix:\n")
		@time graph_matrix = simpleGraph(infile_name, "adjmatrix")

		println("\n# Graph Size report:")
		println("-- Adjacency List size   (In bytes) = ", sizeof(graph_list.Graph))
		println("-- Adjacency Matrix size (In bytes) = ", sizeof(graph_matrix.Graph))
	catch
		error("Error in \"test_one\" function.")
	end
	return "TEST_ONE_SUCESS"
end

"""
Requirement (PT-BR): Compare o desempenho em termos de tempo de execucao
das duas representacoes do grafo. Ou seja, determine o tempo necessario
para executar dez buscas em largura em cada um dos casos (utilize diferentes
vertices como ponto de partida da busca).
"""
function test_two(infile_name::ASCIIString, initial_vertex)
	println("- Starting the Test Two")
	try
		println("\n-- Performing 10 bfs on the Adjacency List:")
		graph_list = simpleGraph(infile_name)

		@time for i in initial_vertex
			fast_bfs(graph_list.Graph, s = i)
		end

		println("\n-- Performing 10 bfs on Adjacency Matrix:")
		graph_matrix = simpleGraph(infile_name, "adjmatrix")

		@time for i in initial_vertex
			fast_bfs(graph_matrix.Graph, s = i)
		end
	catch
		error("Error in \"test_two\" function.")
	end
	return "TEST_TWO_SUCESS"
end

"""
Requirement (PT-BR): Repita o item anterior para busca em profundidade (utilize
os mesmos 10 vertices iniciais)
"""
function test_three(infile_name::ASCIIString, initial_vertex)
	println("- Starting the Test Three")
	try
		# Calculate the time to perform 10 DFS in an Adjacency List
		println("\n-- Performing 10 dfs on the Adjacency List:")
		graph_list = simpleGraph(infile_name)

		@time for i in initial_vertex
			p, t = dfs(graph_list.Graph, s = i)
		end

		# Calculate the time to perform 10 DFS in an Adjacency Matrix
		println("\n-- Performing 10 dfs on Adjacency Matrix:")
		graph_matrix = simpleGraph(infile_name, "adjmatrix")

		@time for i in initial_vertex
			p, t = dfs(graph_matrix.Graph, s = i)
		end
	catch
		error("Error in \"test_three\" function.")
	end
	return "TEST_THREE_SUCESS"
end

"""
Requirement (PT-BR): Determine o pai dos vertices 10, 20, 30, 40, 50 na 
arvore geradora induzida pela BFS e pela DFS quando iniciamos a busca nos 
vertices 1, 2, 3, 4, 5.
"""
function test_four(infile_name::ASCIIString, outfile_name::ASCIIString)
	println("- Starting the Test Four")
	outfile = open(outfile_name, "w")

	try
		initial_vertex = [1 2 3 4 5]
		child = [10 20 30 40 50]
		
		println("\n-- Performing the BFS on the Adjacency List: ")
		graph_list = simpleGraph(infile_name)
		fathers = Array{Array{Int64},1}(length(child))
		
		# Initialize fathers with zeros
		@inbounds @simd for i in 1:length(child)
   	 		fathers[i] = Array{Int64}(0)
    	end

    	write(outfile, "\nBFS TIME\n")
    	# Do the bfs to find the parents and fill
		for i in initial_vertex
			l, p, t = bfs(graph_list.Graph, s = i)
			write(outfile, string("\nInitial vertex = ", i))
			for j in 1:length(child)
				write(outfile, "\nParent of child : ")
				for k in 1:length(p)
					if findfirst(p[k], child[j]) != 0
						fathers[j] = [child[j] k]
						write(outfile, string(fathers[j], "\n"))
						break
					end
				end
			end
		end

		println("\n-- Performing the BFS on the Adjacency List: ")
		fathers_dfs = Array{Array{Int64},1}(length(child))
		# Initialize fathers with zeros
		@inbounds @simd for i in 1:length(child)
   	 		fathers_dfs[i] = Array{Int64}(0)
    	end

    	write(outfile, "\nDFS TIME\n")
    	# Do the bfs to find the parents and fill
		for i in initial_vertex
			p, t = dfs(graph_list.Graph, s = i)
			write(outfile, string("\nInitial vertex = ", i))
			for j in 1:length(child)
				write(outfile, "\nParent of child : ")
				for k in 1:length(p)
					if findfirst(p[k], child[j]) != 0
						fathers_dfs[j] = [child[j] k]
						write(outfile, string(fathers_dfs[j], "\n"))
						break
					end
				end
			end
		end
	catch
		error("Error in \"test_four\" function.")
	finally
		close(outfile)
	end
	return "TEST_FOUR_SUCESS"
end

"""
Requirement (PT-BR): Obtenha as componentes conexas do grafo. Quantas
componentes conexas tem o grafo? Qual e o tamanho da maior e da menor
componente conexo?
"""
function test_five(infile_name::ASCIIString)
	return "TEST_FIVE_SUCESS"
end

"""
Requirement (PT-BR): Obtenha a distribuicao empirica do grau dos vertices.
Trace um grafico com seu resultado. Qual e o maior grau do grafo? E o menor? Como
isto se compara ao maior grau possivel?
"""
function test_six(infile_name::ASCIIString)
	println("\n- Starting the Test Six")
	try
		graph_list = simpleGraph(infile_name)
		println("-- Performing mean_degree and empirical_dist on Adjacency List")
		@time mean_degree, empirical_dist = graph_properties(graph_list)
		
		largest_degree = maximum(empirical_dist) * graph_list.num_vertex
		println("--- Largest degree on the Graph = ", largest_degree)

		smallest_degree = minimum(empirical_dist) * graph_list.num_vertex
		println("--- Smallest degree on the Graph = ", smallest_degree)
	catch
		error("""Error in \"test_six\" function calculating the empirical
		distribution on the as_graph file.""")
	end
	return "TEST_SIX_SUCESS"
end

"""
Requirement (PT-BR): Determine o diametro do grafo. Lembrando que o diametro e
a maior distancia entre qualquer par de vertices do grafo (ou seja, o comprimento
do maior caminho minimo do grafo). Determine tambem o tempo de execucao necessario
para calcular o diametro.
"""
function test_seven(infile_name::ASCIIString)
	return "TEST_SEVEN_SUCESS"
end