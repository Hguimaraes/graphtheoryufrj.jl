using Graphs
using GraphPlot
using Colors
using DataStructures

# create empty array of UInt32 Arrays and initialize with 0. OBS: same as the parents code! THIS ONE IS FAST NO TYPE INFERENCE
#a = Array{Array{UInt32}}(SIZE)
#for i in 1:length(a)
#    a[i]=Array{UInt32}(0)
#    push!(a[i],0)
#end

function rand_graph(x::Int64, gmax::Int64)
    G = Array{Array{Int64}}(x)
    @inbounds @simd for i in 1:x
    	@inbounds G[i]=Array{Int64}(0)
    end

    @inbounds @simd for i in 1:x
        for j in 1:rand(1:gmax)
            r = rand(1:x)
            if r != i
                push!(G[i], r)
            end
        end
    end

    @inbounds for i in 1:x
        for j in G[i]
            if j!=i && !in(i, j)
                push!(G[j],i)
            end
        end
        G[i] = sort(G[i])
        G[i] = unique(G[i])
    end

    @inbounds @simd for i in 1:x
        G[i] = sort(G[i])
        G[i] = unique(G[i])
    end

    return G
end


function bfs(G::Array{Array{Int64},1} ;s=1)
	l = length(G)
    tag = zeros(UInt8,l)
    parents = Array{Array{Int64,1}}(l)

    @simd for i in 1:length(parents)
        @inbounds parents[i]=Array{Int64}(0)
    end

    q = Queue(UInt64)
    tag[s] = 1
    enqueue!(q, s)
    while !isempty(q)
        u = dequeue!(q)
        @inbounds for i in G[u]
            @inbounds if tag[i]==0
                @inbounds tag[i]=1
                @inbounds push!(parents[u], i)
                enqueue!(q,i)
            end
        end
    end
    return parents,tag
end


function fast_bfs(G::Array{Array{Int64},1} ;s=1)
	l = length(G)
    tag = zeros(UInt8,l)
    
    q = Queue(UInt64)
    tag[s] = 1
    enqueue!(q, s)
    while !isempty(q)
        u = dequeue!(q)
        @inbounds for i in G[u]
            @inbounds if tag[i]==0
                @inbounds tag[i]=1
                enqueue!(q,i)
            end
        end
    end
end


function plot_do_bfs(size)

	@time G = rand_graph(size,2)  

	membership = []

	g = simple_graph(0, is_directed=false)

	for i in G
		push!(membership,rand(1:2))
		add_vertex!(g,i)
	end

	for i in 1:length(G)
		for j in G[i]
			add_edge!(g,i,j)
		end
	end

	nodelabel = collect(1:num_vertices(g))

	nodecolor = [colorant"lightseagreen", colorant"orange"]
	# membership color
	nodefillc = nodecolor[membership]
	gplothtml(g, nodefillc=nodefillc, nodelabel=nodelabel)

	@time par,tag=bfs(G)
	# println("Done!")

	p = simple_graph(0, is_directed=false)

	for i in par
	    add_vertex!(p,i)
	end

	for i in 1:length(par)
	    for j in par[i]
	    	# println("dad $i, son $j")
	    	# println(typeof(i))
	    	# println(typeof(j))
	        add_edge!(p,i,j)
	    end
	end

	gplothtml(p , nodelabel=nodelabel)
end

function do_bfs(size)
	println("Make graph")
	@time G = rand_graph(size,2)  
	println("BFS")
	@time bfs(G)
	println("fast BFS")
	@time fast_bfs(G)
	println("Done!")
end

function plot_graph(g; labels = true)

	nodelabel = collect(1:length(g))
	p = simple_graph(0, is_directed=false)

	for i in g
	    add_vertex!(p,i)
	end

	for i in 1:length(g)
	    for j in g[i]
	    	# println("dad $i, son $j")
	    	# println(typeof(i))
	    	# println(typeof(j))
	        add_edge!(p,i,j)
	    end
	end

	if labels == true
		gplothtml(p , nodelabel=nodelabel)
	else
		gplothtml(p)
	end

end