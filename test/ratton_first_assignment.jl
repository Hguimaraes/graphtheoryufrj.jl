using graphtheoryufrj

"""
Requirement (PT-BR): Compare o desempenho em termos de quantidade de memoria
utilizada pelas duas representacoes do grafo. Ou seja, determine a quantidade
de memoria (em MB) utilizada pelo seu programa quando voce representa o grafo
utilizando uma matriz de adjacencia e lista de adjacencia.
"""
function test_one()
	# as_graph Graph.
	outfile = open("as_graph_report.txt", "w")
	try
		as_graph_list = simpleGraph("../assets/as_graph.txt")
		as_graph_matrix = simpleGraph("../assets/as_graph.txt", "adjmatrix")
		write(outfile, string("# as_graph_report Graph","\n"))
		write(outfile, string("-- Adjacency List size   (In bytes) = ", sizeof(as_graph_list.Graph),"\n"))
		write(outfile, string("-- Adjacency Matrix size (In bytes) = ", sizeof(as_graph_matrix.Graph),"\n"))
	catch
		error("Error in \"test_one\" function operating on the as_graph file.")
	finally
		close(outfile)
	end
	# subdblp_report Graph.
	outfile = open("subdblp_report.txt", "w")
	try
		subdblp_list = simpleGraph("../assets/subdblp.txt")
		subdblp_matrix = simpleGraph("../assets/subdblp.txt", format = "adjmatrix")
		write(outfile, string("# subdblp_report Graph","\n"))
		write(outfile, string("-- Adjacency List size   (In bytes) = ", sizeof(subdblp_list.Graph),"\n"))
		write(outfile, string("-- Adjacency Matrix size (In bytes) = ", sizeof(subdblp_matrix.Graph),"\n"))
	catch
		error("Error in \"test_one\" function operating on the subdblp_report file.")
	finally
		close(outfile)
	end
	# dblp_report Graph.
	outfile = open("dblp_report.txt", "w")
	try
		outfile = open("dblp_report.txt", "w")
		dblp_list = simpleGraph("../assets/dblp.txt")
		write(outfile, string("# dblp_report Graph","\n"))
		write(outfile, string("-- Adjacency List size   (In bytes) = ", sizeof(dblp_list.Graph),"\n"))
	catch
		error("Error in \"test_one\" function operating on the dblp_report file.")
	finally
		close(outfile)
	end 

	return "TEST_ONE_SUCESS"
end

"""
Requirement (PT-BR): Compare o desempenho em termos de tempo de execucao
das duas representacoes do grafo. Ou seja, determine o tempo necessario
para executar dez buscas em largura em cada um dos casos (utilize diferentes
vertices como ponto de partida da busca).
"""
function test_two()
	return "TEST_TWO_SUCESS"
end

"""
Requirement (PT-BR): Repita o item anterior para busca em profundidade (utilize
os mesmos 10 vertices iniciais)
"""
function test_three()
	return "TEST_THREE_SUCESS"
end

"""
Requirement (PT-BR): Determine o pai dos vertices 10, 20, 30, 40, 50 na 
arvore geradora induzida pela BFS e pela DFS quando iniciamos a busca nos 
vertices 1, 2, 3, 4, 5.
"""
function test_four()
	return "TEST_FOUR_SUCESS"
end

"""
Requirement (PT-BR): Obtenha as componentes conexas do grafo. Quantas
componentes conexas tem o grafo? Qual e o tamanho da maior e da menor
componente conexo?
"""
function test_five()
	return "TEST_FIVE_SUCESS"
end

"""
Requirement (PT-BR): Obtenha a distribuicao empirica do grau dos vertices.
Trace um grafico com seu resultado. Qual e o maior grau do grafo? E o menor? Como
isto se compara ao maior grau possivel?
"""
function test_six()
	return "TEST_SIX_SUCESS"
end

"""
Requirement (PT-BR): Determine o diametro do grafo. Lembrando que o diametro e
a maior distancia entre qualquer par de vertices do grafo (ou seja, o comprimento
do maior caminho minimo do grafo). Determine tambem o tempo de execucao necessario
para calcular o diametro.
"""
function test_seven()
	return "TEST_SEVEN_SUCESS"
end