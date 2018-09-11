require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def kahn(vertices)
  sorted = []
  queue = []
  vertices.each do |vertex|
    queue << vertex if vertex.in_edges.empty?
    p vertex.value
  end
  until queue.empty?
    current = queue.shift
    sorted << current
    current.out_edges.each do |edge|
      destination = edge.to_vertex
      destination.in_edges.delete(edge)
      if destination.in_edges.empty?
        queue << edge.to_vertex
      end
    end
    vertices.delete(current)
  end
  if vertices.empty?
    sorted
  else
    []
  end
end


def topological_sort(vertices)
  sorted = []
  visited = Hash.new { |h,v| h[v]=false}
  recursionStack=Hash.new{|h,v| h[v]=false}
  vertices.each do |vertex|
    visit(vertex,sorted,visited, recursionStack) if vertex.in_edges.empty?
  end
  sorted
end

def visit(vertex, result, visited, recursionStack)
  return [] if recursionStack[vertex.value]
  return if visited[vertex.value]==true
  visited[vertex.value]=true
  recursionStack[vertex.value]=true
  vertex.out_edges.each do |edge|
    visit(edge.to_vertex,result,visited,recursionStack)
  end
  recursionStack[vertex.value]=false

  result.unshift(vertex)
end
