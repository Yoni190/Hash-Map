class Node
  attr_accessor :value, :next_node

  def initialize(value)
    self.value = value
    self.next_node = nil
  end
end
