require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms

def kahn(vertices)
  sorted = []
  queue = []
  vertices.each do |vertex|
    queue << vertex if vertex.in_edges.empty?
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
  cyclic = []
  vertices.each do |vertex|
    visit(vertex,sorted,visited, cyclic) if vertex.in_edges.empty?
  end
  return sorted unless cyclic.include?(true)
  return []
end


def visit(vertex, result, visited,cyclic)
  if visited[vertex.value]==true
      cyclic << true
      return
  end
  visited[vertex.value]=true
  vertex.out_edges.each do |edge|
    visit(edge.to_vertex,result,visited,cyclic)
  end
  result.unshift(vertex)
end
