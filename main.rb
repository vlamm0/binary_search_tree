require_relative 'lib/Tree'


arr = Array.new(10) { rand(1..100)}

test = Tree.new([1, 7, 4, 23, 8, 9, 4, 6, 3, 5, 7, 9, 12, 67, 6345, 324])
arr.each {|val| test.insert(val)}
test.pretty_print
test.remove(23)
test.pretty_print
#p test.find(324)
#test.level_order {|curr| puts curr.data}
test.indorder {|curr| puts curr.data}
puts
test.preorder {|curr| puts curr.data}
puts
test.postorder {|curr| puts curr.data}