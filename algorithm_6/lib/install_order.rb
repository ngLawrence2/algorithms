# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative 'topological_sort'

def install_order(arr)

  packages = {}
  max = 0
  arr.each do |k|
    package1 = k[0]
    package2 = k[1]
    packages[package1] = Vertex.new(package1) unless packages[package1]
    packages[package2] = Vertex.new(package2) unless packages[package2]
    Edge.new(packages[package1], packages[package2])
    max = package1 if max < package1
    max = package2 if max < package2
  end
  (1..max).each do |k|
    packages[k] = Vertex.new(k) unless packages[k]
  end

  arr = kahn(packages.values).map{ |el| el.value}
  arr.reverse
end
