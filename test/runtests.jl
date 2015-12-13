using graphtheoryufrj
using Base.Test

include("ratton_first_assignment.jl")

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