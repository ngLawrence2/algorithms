class Vertex
  attr_reader :value, :in_edges, :out_edges
  def initialize(value)
    @value = value
    @in_edges=[]
    @out_edges=[]
  end

  def inspect
    "#{@value}#{@in_edges}#{@out_edges}"
  end
end

class Edge
  attr_accessor :from_vertex, :to_vertex
  attr_reader :cost
  def initialize(from_vertex, to_vertex, cost = 1)
    @from_vertex=from_vertex
    @to_vertex=to_vertex
    @cost=cost
    to_vertex.in_edges<<self
    from_vertex.out_edges<<self
  end

  def inspect
    "#{@from_vertex.value}-#{@to_vertex.value}"
  end

  def destroy!
    from_vertex.out_edges.delete(self)
    to_vertex.in_edges.delete(self)
    @from_vertex=nil
    @to_vertex=nil
  end
end
