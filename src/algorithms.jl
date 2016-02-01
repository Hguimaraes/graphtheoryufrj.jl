# graphstructure.jl
# Authors : Heitor Guimaraes and Luiz Ciafrino
# @brief: Module with some algorithms for graphs

# Constants
let
  global infinite = 100000000
end

function bfs(G::Array{Array{Int64},1}; s = 1)
"""
"""
  l = length(G)
  tag = zeros(UInt8,l)
  parents = Array{Array{Int64,1}}(l)
  layer = Array{Int64}(l)

  fill!(layer,-1)

  @simd for i in 1:length(parents)
    @inbounds parents[i] = Array{Int64}(0)
  end

  q = Queue(UInt64)
  tag[s] = 1
  layer[s] = 0
  enqueue!(q, s)
  while !isempty(q)
    u = dequeue!(q)
    @inbounds for i in G[u]
      @inbounds if tag[i] == 0
        @inbounds tag[i] = 1

        if layer[i] == -1
          layer[i] = layer[u] + 1
        end

        @inbounds push!(parents[u], i)
        enqueue!(q,i)
      end
    end
  end

  return layer,parents,tag
end

function bfs(G::Array{UInt8,2}; s = 1)
"""
"""
  x_dim, y_dim = size(G)
  l = x_dim
  tag = zeros(UInt8,l)
  parents = Array{Array{Int64,1}}(l)
  layer = Array{Int64}(l)

  fill!(layer,-1)

  @simd for i in 1:length(parents)
    @inbounds parents[i] = Array{Int64}(0)
  end

  q = Queue(UInt64)
  tag[s] = 1
  layer[s] = 0
  enqueue!(q, s)
  while !isempty(q)
    u = dequeue!(q)
    @inbounds for i in 1:x_dim
      @inbounds if G[i,u] == 1 && tag[i] == 0
        @inbounds tag[i] = 1

        if layer[i] == -1
          layer[i] = layer[u] + 1
        end

        @inbounds push!(parents[u],i)
        enqueue!(q,i)
      end
    end
  end

  return layer,parents,tag
end

function dfs(G::Array{Array{Int64},1}; s = 1)
"""
"""
  l = length(G)
  tag = zeros(UInt8,l)
  parents = Array{Array{Int64,1}}(l)

  @simd for i in 1:length(parents)
    @inbounds parents[i] = Array{Int64}(0)
  end

  p = Stack(UInt64)
  push!(p, s)
  while !isempty(p)
    u = pop!(p)
    if tag[u] <= 1
      tag[u] = 2
      for i in G[u]
        push!(p,i)
        if tag[i] == 0
          push!(parents[u], i)
          tag[i] = 1

        end
      end
    end
  end

  return parents,tag
end

function dfs(G::Array{UInt8,2}; s = 1)
"""
"""
  x_dim, y_dim = size(G)
  l = x_dim
  tag = zeros(UInt8,l)
  parents = Array{Array{Int64,1}}(l)

  @simd for i in 1:length(parents)
    @inbounds parents[i]=Array{Int64}(0)
  end

  p = Stack(UInt64)
  push!(p, s)
  while !isempty(p)
    u = pop!(p)
    if tag[u] == 0
      tag[u] = 1
      for i in 1:x_dim
        if G[i,u] == 1
          push!(p,i)
          if tag[i] == 0
            push!(parents[u], i)
          end
        end
      end
    end
  end

  return parents,tag
end

function fast_bfs(G::Array{Array{Int64},1}; s = 1)
"""
"""
  l = length(G)
  tag = zeros(UInt8,l)

  q = Queue(UInt64)
  tag[s] = 1
  enqueue!(q, s)
  while !isempty(q)
    u = dequeue!(q)
    @inbounds for i in G[u]
      @inbounds if tag[i] == 0
        @inbounds tag[i] = 1
        enqueue!(q,i)
      end
    end
  end
end

function fast_bfs(G::Array{UInt8,2}; s = 1)
"""
"""
  x_dim, y_dim = size(G)
  l = x_dim
  tag = zeros(UInt8,l)

  q = Queue(UInt64)
  tag[s] = 1
  enqueue!(q, s)
  while !isempty(q)
    u = dequeue!(q)
    @inbounds for i in 1:x_dim
      @inbounds if G[i,u] == 1 && tag[i] == 0
        @inbounds tag[i] = 1
        enqueue!(q,i)
      end
    end
  end
end

function has_cycle(G::Array{Array{Int64},1}; s = 1)
"""
"""
  l = length(G)
  layer = Array{Int64}(l)

  q = Queue(UInt64)

  for i in 1:length(layer)
    layer[i]=-1
  end

  for v in 1:l
    if layer[v] != -1
      continue
    else
      println("Layer not explored")
      layer[v] = 0
      println("First Enq $v")
      enqueue!(q, v)
      while !isempty(q)
        u = dequeue!(q)
        println("Deq $u")
        println("Layer[u] is ", layer[u] )
        for z in G[u]
          println("z = $z")
          println("Layer of z ", layer[z])
          if layer[z] == -1
            layer[z] = layer[u]+1
            println("Layer[z] is ", layer[z] )
            println("Enq $z")
            enqueue!(q, z)
          elseif layer[z]>= layer[u]
              return layer
          end
        end
        println("_______________")
      end
    end
  end

  return false
end

function show_cycle(layer)
"""
"""
  parents = []

  for i in 1:length(layer)
    if layer[i] > -1
      push!(parents,i)
    end
  end
  return parents
end

function connected_components(G::Array{Array{Int64},1})
"""
"""
  l, p, t = bfs(G, s = 1)
  num_cc = 1
  size_cc = []

  s = 0
  for i in 1:length(t)
    if t[i] == 1
      s += 1
    end
  end
  push!(size_cc, s)

  while findfirst(t, 0) != 0
    l_tmp, p_tmp, t_tmp = bfs(G, s = findfirst(t, 0))

    s = 0
    for i in 1:length(t_tmp)
      if t_tmp[i] == 1
        s += 1
      end
    end
    push!(size_cc, s)
    t = broadcast(|, t, t_tmp)
  end

  return size_cc
end

function dia_bfs(G::Array{Array{Int64},1}; s = 1)
"""
"""
  l = length(G)
  tag = zeros(UInt8,l)
  layer = Array{Int64}(l)

  fill!(layer,-1)

  q = Queue(UInt64)
  tag[s] = 1
  layer[s] = 0
  enqueue!(q, s)
  while !isempty(q)
    u = dequeue!(q)
    @inbounds for i in G[u]
      @inbounds if tag[i] == 0
        @inbounds tag[i] = 1

        if layer[i] == -1
          layer[i] = layer[u] + 1
        end

        enqueue!(q,i)

      end
    end
  end

  return layer
end

function diameter(G::Array{Array{Int64},1}, limit)
"""
"""
  max = 0
  @simd for i in 1:limit
    layer = dia_bfs(G, s=i)
    m = maximum(layer)
    if m > max
      max = m
    end
  end

  return max
end

function dijkstra(G, s, infinite_weight = infinite)
"""
"""
	l = length(G)
	pq = Collections.PriorityQueue()

	prev = Array{Float64}(l)

  	dist = Array{Float64}(l)
  	fill!(dist, infinite_weight)
  	fill!(prev, -1)

  	dist[s] = 0

  	for i in 1:l
  		pq[i] = dist[i]
  	end

  	while !isempty(pq)
  		u = Collections.dequeue!(pq)
      u = convert(Int64, u)
      for k in 1:length(G[u][1])
  			alt = dist[u] + G[u][2][k]


  			v = G[u][1][k]
        v = convert(Int64, v)
        if alt < dist[v]
  				dist[v] = alt
  				prev[v] = u
  				pq[v] = alt
  			end


  		end
  	end
  	return dist, prev
end


function floydw(G, infinite_weight = infinite)
"""
"""
	l = length(G)
	V = fill(infinite_weight, l, l)

	for i in 1:l
		V[i,i] = 0
	end

	for i in 1:l
		u = i
		for k in length(G[u][1])
			v = G[u][1][k]
      V[u,v] = G[u][2][k]
		end
	end

  for k = 1:l, i = 1:l, j = 1:l
    d = V[i,k] + V[k,j]
    if d < V[i,j]
      V[i,j] = d
    end
  end
	return V
end

function prim_mst(G, s, infinite_weight = infinite)
"""
"""
	l = length(G)
	pq = Collections.PriorityQueue()

	prev = Array{Int64}(l)
  dist = Array{Int64}(l)

  fill!(dist, infinite_weight)
	fill!(prev, -1)

	dist[s] = 0

  for i in 1:l
    pq[i] = dist[i]
  end

  while !isempty(pq)
    u = Collections.dequeue!(pq)

    for k in 1:length(G[u][1])
      alt = G[u][2][k]
      v = G[u][1][k]

      if haskey(pq,v) && alt < dist[v]
  		    dist[v] = alt
  				prev[v] = u
  				pq[v] = alt
  		end
    end
  end
  	return dist, prev
end

function mean_distance_dijkstra(G, infinite_weight = infinite)
"""
"""
  l = length(G)
  M = 0
  N = 0
  for i in 1:l
    d,_ = dijkstra(G,i)
    for j in d
      if j < infinite_weight
        M += j
        N += 1
      end
    end
  end
  return M/N
end

function mean_distance_fw(G, infinite_weight = infinite)
"""
"""
  l = length(G)
  V = fill(infinite_weight, l, l)
  M = N = 0

  for i in 1:l
    V[i,i] = 0
    for j in length(G[i][1])
      v = G[i][1][j]
      V[i,v] = G[i][2][j]
    end
  end

  for k = 1:l, i = 1:l, j = 1:l
    d = V[i,k] + V[k,j]
    if d < V[i,j]
      V[i,j] = d
    end
  end

  for i in V
    if i < infinite_weight
      M += i
      N += 1
    end
  end

  return M/N
end
