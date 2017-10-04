require 'minitest/autorun'

class LRUCache

=begin
    :type capacity: Integer
=end
    def initialize(capacity)
      @capacity = capacity
      @head = Node.new(nil, nil)
      @tail = Node.new(nil, nil)
      @head.next = @tail
      @tail.prev = @head
      @map = {}
      #@size = 0
    end


=begin
    :type key: Integer
    :rtype: Integer
=end
    def get(key)
      result = nil
      if !@map.has_key?(key)
        result = -1
        return result
      end

      node = @map[key]
      take_out_node(node)
      insert_at_head(node)

      return node.val
    end


=begin
    :type key: Integer
    :type value: Integer
    :rtype: Void
=end
    def put(key, value)
      node = nil
      if @map.has_key?(key)
        # key exist
        node = @map[key]
        node.val = value
        take_out_node(node)
      else
        if @map.size == @capacity
          # handle the case that capacity == 0
          if @tail.prev != @head
            node = take_out_node(@tail.prev)
            @map.delete(node.key)
          end
        end

        if @map.size < @capacity
          node = Node.new(key, value)
          @map[key] = node
        end
      end

      insert_at_head(node)
      nil
    end

    def take_out_node(node)
      prv = node.prev
      nxt = node.next
      prv.next = nxt
      nxt.prev = prv
      return node
    end

    def insert_at_head(node)
      prv = @head
      nxt = @head.next

      prv.next = node
      node.prev = prv

      nxt.prev = node
      node.next = nxt

      return node
    end

end

class Node
  attr_accessor :prev, :next, :key, :val
  def initialize(key, val)
    @key = key
    @val = val
  end
end

# Your LRUCache object will be instantiated and called as such:
# obj = LRUCache.new(capacity)
# param_1 = obj.get(key)
# obj.put(key,value)

describe 'LRUCache' do
  before(:each) do
    @cache = LRUCache.new(3)
    @cache.put(1,1)
    @cache.put(2,2)
    @cache.put(3,3)
  end

  it 'should work1' do
    @cache.get(3).must_equal(3)
    @cache.get(2).must_equal(2)
    @cache.get(1).must_equal(1)

    @cache.put(4,4)
    @cache.get(4).must_equal(4)
    @cache.get(3).must_equal(-1)
  end

  it 'should work2' do
    @cache = LRUCache.new(2)
    commands = ["LRUCache","get","put","get","put","put","get","get"]
    arguments = [[2],[2],[2,6],[1],[1,5],[1,2],[1],[2]]
    expected_results = [nil,-1,nil,-1,nil,nil,2,6]

    i = 1
    results = []
    while i < commands.length do
      result = @cache.send(commands[i].to_sym, *arguments[i])
      results << result
      i += 1
    end
    results.must_equal(expected_results[1...expected_results.length])

  end
end
