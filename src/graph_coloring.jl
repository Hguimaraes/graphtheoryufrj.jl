using JuMP, Gurobi

include("graphtheoryufrj.jl")
include("random_graphs.jl")


function coloring(G::Array{Array{Int64},1})
	l = length(G)
	colors = zeros(Int,l)
	vertex_color = zeros(Int,l)

	colors[1] = 1
	vertex_color[1] = 1

	for i in 2:l
		unavailable = 0
		for j in G[i]
			if vertex_color[j] >= 1 && vertex_color[j] > unavailable
				unavailable = vertex_color[j]
			end
		end
		vertex_color[i] = unavailable+1
		colors[unavailable+1] = 1

	end
	return colors

end

function gurobi_coloring(G::Array{Array{Int64},1}, E)

	n = length(G)
	h = convert(Int, sum(coloring(G)))
	println("Greedy heuristic $h")

	m = Model(solver=GurobiSolver(TimeLimit = 3600, Method=0, MIPFocus=2, Cuts=3, MIPGap=0.03))

	@defVar(m, x[1:n, 1:h], Bin)
	@defVar(m, y[1:h], Bin)

	@addConstraint(m, constr[i=1:n], sum{x[i,k], k=1:h} == 1 )
	@addConstraint(m, xyconstr[i=1:n, k=1:h], x[i,k] - y[k] <= 0)

	for e in E
		for k in 1:h
			a= e[1]
			b= e[2]
			@addConstraint(m, x[a,k] + x[b,k] <= 1)
		end
	end

	@setObjective(m, Min, sum{y[i], i=1:h})

	@time solve(m)

	return getObjectiveValue(m), getValue(y), getValue(x)
end

function edges(G::Array{Array{Int64},1})
	E = Tuple{Int,Int}[]
	n = length(G)
	for i in 1:n
		for j in G[i]
			push!(E, (i,j))
		end
	end
	return E
end

function run(name)
	g = graphtheoryufrj
	G = g.simpleGraph(name)
	G = G.Graph
	E=edges(G)

	obj,y,x = gurobi_coloring(G, E)
	println("Objective value of $obj")
end

println("Compile run")
run("g.txt")
println("Timing run")
run("queen10_10.txt")



