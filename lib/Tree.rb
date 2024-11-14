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
    return curr if curr.data == value
    return nil if curr.data == nil
    # recurse 
    curr = find(curr.right, value) if curr.data < value 
    curr = find(curr.left, value) if curr.data > value
    curr
  end

  def level_order(q = [root], &block)#&block
    # base case
    return if q.empty?
    # recurse
    curr = q.shift
    q.push(curr.left) if !curr.left.nil?
    q.push(curr.right) if !curr.right.nil?
    yield(curr)
    level_order(q, &block)
    #iterative approach
    # while !q.empty?
    #   curr = q.shift
    #   q.push(curr.left) if !curr.left.nil?
    #   q.push(curr.right) if !curr.right.nil?
    #   yield(curr)
    # end
  end

  def indorder(&block)
    dfs("in", &block)
  end

  def preorder(curr = root, &block)
    dfs("pre", &block)
  end

  def postorder(curr = root, &block)
    dfs("post", &block)
  end

  def dfs(curr = root, order, &block)
    #base
    return nil if curr.nil?
    #recurse
    yield(curr) if order == "pre"
    dfs(curr.left, order, &block)
    yield(curr) if order == "in"
    dfs(curr.right, order, &block)
    yield(curr) if order == "post"
  end

  def height(node)
    # base
    children = [node.right, node.left].select {|child| !child.nil?}
    return 0 if children.empty?
    
    # recurse
    heights = children.map {|child| height(child)}
    heights.max + 1
  end

  def depth(target, curr = root)
    # recursive
    # return 0 if curr == target
    # counter = 1
    # counter += depth(target, curr.right) if curr < target
    # counter += depth(target, curr.left) if curr > target
    # counter
    #iterative
    counter = 0
    while curr != target
      curr < target ? curr = curr.right : curr = curr.left
      counter += 1
    end
    counter
  end

end