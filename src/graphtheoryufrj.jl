#
#
#
#

module graphtheoryufrj
using DataStructures, Compat

export 
	abstractGraph,
	
	# Graph data structure
	Graph,
	demoGraph,

	# Algorithms
	bfs,
	fast_bfs,
	dfs,

	# Plot data
	plot_graph,
	plot_bfs,
	plot_dfs

# Load source files
include("algorithms.jl")
include("graphstructure.jl")
include("plot.jl")

end