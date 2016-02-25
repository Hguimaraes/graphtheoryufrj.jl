using JuMP, Gurobi, DataStructures

include("graphtheoryufrj.jl")
include("random_graphs.jl")
include("dsatur.jl")

function direct_coloring(G::Array{Array{Int64},1})
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

function gurobi_coloring(G::Array{Array{Int64},1}, E, tmax, r)

	n = length(G)
	h = convert(Int, length(Set(dsatur(G))))
	println("DSATUR greedy coloring $h")
	if h-r > 0
		h = h-r
	end
	println("Solving for DSATUR - $r colors = $h")

	m = Model(solver=GurobiSolver(TimeLimit = tmax, Method=-1, MIPFocus=1, Cuts=3, MIPGap=0.1))

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

	@time status = solve(m)

	return getObjectiveValue(m), getValue(y), getValue(x), status
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

function load(name)
	println("Loading graph $name")
	g = graphtheoryufrj
	G = g.simpleGraph(name)
	G = G.Graph
	E=edges(G)
	return G,E
end

function run(name, tmax, r)
	println("Coloring graph $name")
	g = graphtheoryufrj
	G = g.simpleGraph(name)
	G = G.Graph
	E=edges(G)

	obj,y,x,status = gurobi_coloring(G, E, tmax, r)
	println("Objective value of $obj")
	return obj,y,x,status
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

function color_report(i, tmax, r)
	name = "G$(i).txt"

	t = @elapsed obj,y,x,status = run(name, tmax, r)
	_,sim = colors(x)

	f = open("$(time())color_$(name)", "w")
	write(f, "optimization status = $(status)\n")
	write(f, "chromatic number = $(obj)\n")
	write(f, "runtime = $(t)\n")
	write(f, "$(sim)\n")
	close(f)
end

# l = ["dsjc1000_9.txt", "dsjc1000_5.txt", "dsjc1000_1.txt", "dsjc500_9.txt", "dsjc500_5.txt", "dsjc500_1.txt"]
# for i in l
# 	name = i
# 	g = graphtheoryufrj
# 	println("Graph $(name)")
# 	@time G = g.simpleGraph(name)
# 	G = G.Graph
# 	E=edges(G)
# 	t = @elapsed d = length(Set(dsatur(G)))
# 	println("K = $(d), time = $(t)")
# 	println("=========================================")
# end
# l = []

# for i in 1:20
# 	name = "G$(i).txt"
# 	g = graphtheoryufrj
# 	G = g.simpleGraph(name)
# 	G = G.Graph
# 	E=edges(G)
# 	d = length(Set(dsatur(G)))

# 	push!(l, (d*length(E), name))
# end

# # DRIVER PROGRAM
println("Compile run")
run("g.txt", 10, 0)
println("==================================================")
cd("t3")
color_report(4, 60*10, 1)
color_report(6, 60*10, 1)



## RUN AND SAVE JUST GREEDY REPORT
# cd("t3")
# name = "G18.txt"
# g = graphtheoryufrj
# G = g.simpleGraph(name)
# G = G.Graph
# E=edges(G)
# t = @elapsed d = dsatur(G)
# obj = length(Set(d))
# f = open("color_$(name)", "w")
# write(f, "optimization status = greedy\n")
# write(f, "chromatic number = $(obj)\n")
# write(f, "runtime = $(t)\n")
# write(f, "$(d)\n")
# close(f)