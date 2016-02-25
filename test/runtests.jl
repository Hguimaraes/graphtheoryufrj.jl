using graphtheoryufrj
using Base.Test

include("ratton_first_assignment.jl")
include("ratton_second_assignment.jl")
"""
First assignment: Basics of a graph package (Modeling, BFS, DFS...)
"""
FLAG_RATTON_ASSIGNMENT01 = false
infile_name = "../assets/as_graph.txt"
outfile_name = "parents_q4.txt"
initial_vertex = [1 5 10 50 100 500 1000 5000 10000 25000]

if FLAG_RATTON_ASSIGNMENT01
	# Test the memory representation of the structures of the graph.
	@test test_one(infile_name) == "TEST_ONE_SUCESS"

	# Time to perform 10 bfs on the graph.
	@test test_two(infile_name, initial_vertex) == "TEST_TWO_SUCESS"

	# Time to perform 10 dfs on the graph.
	@test test_three(infile_name, initial_vertex) == "TEST_THREE_SUCESS"

	# Find the parents of given nodes.
	@test test_four(infile_name, outfile_name) == "TEST_FOUR_SUCESS"

	#
	@test test_five(infile_name) == "TEST_FIVE_SUCESS"

	# Empirical distribuiton test.
	@test test_six(infile_name) == "TEST_SIX_SUCESS"

	#
	@test test_seven(infile_name) == "TEST_SEVEN_SUCESS"
end

"""
First assignment: Extending the graph package (Dijkstra, Floyd-Warshall...)
"""
FLAG_RATTON_ASSIGNMENT02 = false
algorithm = prim_mst
initial_vertex_mst = 20
infile_name = ["../assets/grafo_1.txt",
	"../assets/grafo_2.txt",
	"../assets/grafo_3.txt",
	"../assets/grafo_4.txt",
	"../assets/grafo_5.txt"]

if FLAG_RATTON_ASSIGNMENT02
	for i in infile_name
		#
		@test test_one(i) == "TEST_ONE_SUCESS"

		#
		@test test_two(i, algorithm, initial_vertex_mst) == "TEST_TWO_SUCESS"

		#
		@test test_three(i) == "TEST_THREE_SUCESS"

	end

	#
	@test test_colab_one() == "TEST_COLAB_ONE_SUCESS"

	#
	@test test_colab_two() == "TEST_COLAB_TWO_SUCESS"

end
