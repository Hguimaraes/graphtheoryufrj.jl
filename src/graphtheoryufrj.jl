#
#
#
#

module graphtheoryufrj
using DataStructures, Compat

export 
	# Graph data structure
	simpleGraph,
	demoGraph,
	asAdjList,
	asAdjMatrix,

	# Algorithms
	bfs,
	fast_bfs,
	dfs,

	# Plot data
	plot_graph,
	plot_bfs,
	plot_dfs

# Load source files
include("graphstructure.jl")
include("algorithms.jl")
include("plot.jl")

end