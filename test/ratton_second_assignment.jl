using graphtheoryufrj
using DataStructures

"""
Requirement (PT-BR): Calcule a distancia e o menor caminho a partir dos 
vertices 10, 20, 30, 40, 50 para todos os outros vertices do grafo. Obtenha
o tempo de execucao para calcular todas estas distancias. Reporte a distancia
e um caminho minimo entre os vertices de origem e o vertice 1.
"""
function test_one(infile_name::ASCIIString)
	println("- Starting the Test One")
	#try
		initial_vertex = [10 20 30 40 50]
		
		println("\n-- Performing 5 Dijkstras on the Adjacency List: ")
		graph_list = simpleGraph(infile_name)
		
		# Do the Dijkstra to find the shortest path
		@time for i in initial_vertex
			dist, prev = dijkstra(graph_list.Graph, i)
		end
	#catch
	#	error("Error in \"test_one\" function.")
	#end
	return "TEST_ONE_SUCESS"
end

"""
Requirement (PT-BR): Obtenha uma arvore geradora minima, informando seu peso.
Obtenha o tempo de execucao para resolver este problema.
"""
function test_two(infile_name::ASCIIString, algorithm::Function, initial_vertex)
	println("- Starting the Test Two")
	try
		println("\n-- Performing the algorithm to obtain the MST")
		graph_list = simpleGraph(infile_name)
		@time dist, prev = algorithm(graph_list.Graph, initial_vertex)
	catch
		error("Error in \"test_two\" function.")
	end
	return "TEST_TWO_SUCESS"
end

"""
Requirement (PT-BR): Calcule a distancia media do grafo. Obtenha o tempo de
execucao para resolver este problema.
"""
function test_three(infile_name::ASCIIString)
	println("- Starting the Test Three")
	try
		println("\n-- Performing the mean_distance algorithm")
		graph_list = simpleGraph(infile_name)
		@time mean = mean_distance(graph_list.Graph)
	catch
		error("Error in \"test_three\" function.")
	end
	return "TEST_THREE_SUCESS"
end

"""
Requirement (PT-BR): Calcule a distancia e o caminho minimo entre Edsger W.
Dijkstra (o pesquisador) e os seguintes pesquisadores na rede de colaboracao:
Alan M. Turing, J. B. Kruskal, Jon M. Kleinberg, Eva Tardos, Daniel R. Figueiredo.
"""
function test_colab_one()
	println("- Starting the Test One of the colaboration network")
	try
		
	catch
		error("Error in \"test_colab_one\" function.")
	end
	return "TEST_COLAB_ONE_SUCESS"
end

"""
Requirement (PT-BR): Obtenha uma arvore geradora minima, e responda as 
seguintes perguntas:
(a) Determine os tres vertices de maior grau na MST.
(b) Determine os vizinhos de Edsger W. Dijkstra e de Daniel R. Figueiredo na MST.
"""
function test_colab_two()
	println("- Starting the Test Two of the colaboration network")
	try

	catch
		error("Error in \"test_colab_two\" function.")
	end
	return "TEST_COLAB_TWO_SUCESS"
end