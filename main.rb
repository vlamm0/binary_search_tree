require_relative 'lib/Node'

greater_node = Node.new(2)
lesser_node = Node.new(1)

p greater_node > lesser_node
p greater_node < lesser_node