class Node
  include Comparable
  attr_accessor :data, :left, :right
  
  def <=>(node)
    data <=> node.data
  end

  def initialize(data)
    self.data = data
    self.left = nil
    self.right = nil
  end
end
