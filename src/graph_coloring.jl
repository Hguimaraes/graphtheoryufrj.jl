using JuMP, Gurobi, DataStructures

include("graphtheoryufrj.jl")
include("random_graphs.jl")
include("dsatur.jl")

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
	h1 = convert(Int, sum(coloring(G)))
	h2 = convert(Int, sum(Set(dsatur(G))))
	println("Simple greedy coloring $h1")
	println("DSATUR greedy coloring $h2")

	h = min(h1, h2)

	m = Model(solver=GurobiSolver(TimeLimit = 600, PrePasses=1, Method=0, MIPFocus=2, Cuts=3, MIPGap=0.03))

	@defVar(m, x[1:n, 1:h], Bin)
	@defVar(m, y[1:h], Bin)

	@addConstraint(m, constr[i=1:n], sum{x[i,k], k=1:h} == 1 )
	println("Added constrain 1")

	@addConstraint(m, xyconstr[i=1:n, k=1:h], x[i,k] - y[k] <= 0)
	println("Added constrain 2")

	for e in E
		for k in 1:h
			a= e[1]
			b= e[2]
			@addConstraint(m, x[a,k] + x[b,k] <= 1)
		end
	end
	println("Added constrain 3")

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
	println("Coloring graph $name")
	g = graphtheoryufrj
	G = g.simpleGraph(name)
	G = G.Graph
	E=edges(G)

	obj,y,x = gurobi_coloring(G, E)
	println("Objective value of $obj")
	return obj,y,x
end

function colors(x::Array{Float64,2})
	ret = Array{Int}(size(x)[1])
	for i in 1:size(x)[1]
		for j in 1:size(x)[2]
			if x[i,j] == 1
				ret[i]=j
			end
		end
	end
	ret2 = Array{Int}(size(x)[1])
	c = 0
	for i in Set(ret)
		for j in find(ret .== i)
			ret2[j] = c
		end
		c+=1
	end
	return ret, ret2
end

function coloring_correct(E, color)

	err = 0
	for i in E
		if color[i[1]] == color[i[2]]
			err+=1
		end
	end

	if err == 0
		return true
	else
		return err
	end

end



# println("Compile run")
# run("g.txt")

# println("=============================================================")
# println("Timing run")
# @time obj,y,x = run("latin_square_10.txt")
# orig, sim = colors(x)

g = graphtheoryufrj
G = g.simpleGraph("latin_square_10.txt")
G = G.Graph
E=edges(G)

color = dsatur(G)
println(length(Set(color)))


