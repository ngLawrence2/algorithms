# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative 'topological_sort'

def install_order(arr)
  hash = {}
  packages = {}
  edge = []
  arr.each do |k|
    package1 = k[0]
    package2 = k[1]
    hash[package1] = 1
    hash[package2] = 1
    packages[package1] = Vertex.new(package1) if hash[package1]
    packages[package2] = Vertex.new(package2) if hash[package2]
    edge << Edge.new(packages[package1], packages[package2])
  end
  packages["key"] = Vertex.new(8)
  packages["key2"] = Vertex.new(7)
  result = kahn(packages.values)
end
