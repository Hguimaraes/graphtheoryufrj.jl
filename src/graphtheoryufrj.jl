# graphtheoryufrj.jl
# Authors : Heitor Guimaraes and Luiz Ciafrino
# @brief: Package control file with include of all files and functions.

module graphtheoryufrj
using DataStructures, Compat

export
	# Graph data structure
	simpleGraph,
	graph_properties,

	# Algorithms
	bfs,
	fast_bfs,
	dfs,
	connected_components,
	show_cycle,
	has_cycle,
	dia_bfs,
	diameter,
	dijkstra,
	floydw,
	prim_mst,
	mean_distance_dijkstra,
	mean_distance_fw,

	# Graph_Coloring
	direct_coloring,
	gurobi_coloring,
	edges,
	load,
	run,
	colors,
	coloring_correct,
	color_report,

	#DSATUR
	run_dsatur_heuristc,
	run_optdsatur_heuristc,
	dsatur,
	optdsatur,
	iteratedGreedy,
	localSearch,
	colorGraph,

	# Plot data
	plot_graph,
	plot_bfs,
	plot_dfs

# Load source files
include("graphstructure.jl")
include("algorithms.jl")
include("graph_coloring.jl")
include("dsatur.jl")
include("plot.jl")

end
