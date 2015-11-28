# graphstructure.jl
# Authors : Heitor Guimaraes and Luiz Ciafrino
# @brief: Module with some algorithms for graphs

function bfs(G::Array{Array{Int64},1} ;s=1)
"""
"""
  l = length(G)
  tag = zeros(UInt8,l)
  parents = Array{Array{Int64,1}}(l)
  layer = Array{Int64}(l)

  fill!(layer,-1)

  @simd for i in 1:length(parents)
    @inbounds parents[i]=Array{Int64}(0)
  end

  q = Queue(UInt64)
  tag[s] = 1
  layer[s] = 0
  enqueue!(q, s)
  while !isempty(q)
    u = dequeue!(q)
    @inbounds for i in G[u]
      @inbounds if tag[i]==0
        @inbounds tag[i]=1

        if layer[i] == -1
          layer[i] = layer[u]+1
        end
        
        @inbounds push!(parents[u], i)
        enqueue!(q,i)
              
      end
    end
  end

  return layer,parents,tag
end

function has_cycle(G::Array{Array{Int64},1} ;s=1)
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
    if layer[i]>-1
      push!(parents,i)
    end
  end
  return parents
end

function dfs(G::Array{Array{Int64},1} ;s=1)
"""
"""
  l = length(G)
  tag = zeros(UInt8,l)
  parents = Array{Array{Int64,1}}(l)

  @simd for i in 1:length(parents)
    @inbounds parents[i]=Array{Int64}(0)
  end

  p = Stack(UInt64)
  push!(p, s)
  while !isempty(p)
    u = pop!(p)
    println("pop: $u") 
    if tag[u]==0
      tag[u]=1
      println("Untagged $u")
      for i in G[u]
        println("neighbours $i") 
        push!(p,i)
        if tag[i]==0
          push!(parents[u], i)
        end
      end
    end
  end

  return parents,tag
end

function fast_bfs(G::Array{Array{Int64},1} ;s=1)
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
      @inbounds if tag[i]==0
        @inbounds tag[i]=1
        enqueue!(q,i)
      end
    end
  end
end