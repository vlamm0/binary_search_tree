require_relative 'lib/Tree'


test = Tree.new(Array.new(8) { rand(1..100)})
arr = Array.new(8) { rand(1..100)}
arr.each {|node| test.insert(node)}
test.pretty_print