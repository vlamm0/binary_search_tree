require_relative 'lib/Tree'


arr = Array.new(10) { rand(1..100)}

test = Tree.new([1, 7, 4, 23, 8, 9, 4, 6, 3, 5, 7, 9, 12, 67, 6345, 324])
arr.each {|val| test.insert(val)}
test.pretty_print
test.remove(23)
test.pretty_print
puts test.height(test.find(8))
puts test.height(test.find(12))
puts test.height(test.find(67))
puts test.depth(test.find(8))
puts test.depth(test.find(4))
puts test.depth(test.find(12))