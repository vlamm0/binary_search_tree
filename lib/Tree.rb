require_relative "Node"

class Tree
  attr_accessor :root

  def initialize(arr)
    self.root = build_tree(arr.uniq!.sort, 0, arr.length - 1)#arr.length.nil? ? nil : Node.new(arr[(arr.length-1)/2])
  end

  def build_tree(arr, start, tail)
    # base
    return nil if start > tail

    # vars
    mid = (tail + start)/2    
    curr = Node.new(arr[mid])

    # recurse
    curr.left = build_tree(arr, start, mid - 1)
    curr.right = build_tree(arr, mid + 1, tail)
    curr
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(curr = root, value)
    value = Node.new(value) if value.is_a?(Integer)
    # base case
    return value if curr.nil?
    return curr if curr == value

    # recursive case
    curr < value ? curr.right = insert(curr.right, value) : curr.left = insert(curr.left, value)
    return curr
  end

  def remove(curr = root, value)
    # base care
    return curr if curr.nil?

    # recursive case
    curr.right = remove(curr.right, value) if curr.data < value 
    curr.left = remove(curr.left, value) if curr.data > value

    if curr.data == value
      #child
      children = [curr.left, curr.right]
      return nil if children.all? {|child| child.nil?}
      return children.select {|child| !child.nil?}[0] if children.any? {|child| child.nil?}

      #children
      curr.data = find_min(curr.right).data
      curr.right = remove(curr.right, curr.data)
    end
    curr
  end

  def find_min(node)
    while node.left
      node = node.left
    end
    node
  end

  def find(curr = root, value)
    # base case
    return curr if curr.data = value

    # recurse 
    find(curr.right, value) if curr.data < value 
    find(curr.left, value) if curr.data > value
  end

end