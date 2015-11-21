#
#
#
#

function bfs(G::Array{Array{Int64},1}, s = 1)
"""
"""	
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

function dfs(G::simpleGraph, s = 1)
	println("Using DFS on the selected Graph...")
end