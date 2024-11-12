require_relative "Node"

class Tree
  attr_accessor :root

  def initialize(arr)
    self.root = build_tree(arr.uniq.sort, 0, arr.length - 1)#arr.length.nil? ? nil : Node.new(arr[(arr.length-1)/2])
  end

  def build_tree(arr, start, tail)
    # base
    return nil if start > tail

    # vars
    mid = (tail + start)/2
    subtree_root = Node.new(arr[mid])

    # recurse
    subtree_root.left = build_tree(arr, start, mid - 1)
    subtree_root.right = build_tree(arr, mid + 1, tail)
    subtree_root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(subroot = root, value)
    value = Node.new(value) if value.is_a?(Integer)
    # base case
    return value if subroot.nil?
    return subroot if subroot == value

    # recursive case
    subroot < value ? subroot.right = insert(subroot.right, value) : subroot.left = insert(subroot.left, value)
    subroot
  end
end