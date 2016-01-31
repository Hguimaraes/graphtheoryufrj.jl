#
#
#
#

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
	mean_distance,
	floydw,
	prim_mst,

	# Plot data
	plot_graph,
	plot_bfs,
	plot_dfs

# Load source files
include("graphstructure.jl")
include("algorithms.jl")
include("plot.jl")

end