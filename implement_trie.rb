require 'minitest/autorun'

class Trie

=begin
    Initialize your data structure here.
=end
    def initialize()
      @root = Node.new
    end


=begin
    Inserts a word into the trie.
    :type word: String
    :rtype: Void
=end
    def insert(word)
      n = @root
      word.chars.each_with_index do |chr, i|
        if !n.next.has_key?(chr)
          n.next[chr] = Node.new
        end
        n = n.next[chr]
      end
      #puts "insert n=#{n}"

      n.is_end = true
    end


=begin
    Returns if the word is in the trie.
    :type word: String
    :rtype: Boolean
=end
    def search(word)
      n = start_with_helper(word)
      #puts "n=#{n}"
      #puts "n=#{n}, n.is_end=#{n.is_end}"
      return !n.nil? && n.is_end
    end


=begin
    Returns if there is any word in the trie that starts with the given prefix.
    :type prefix: String
    :rtype: Boolean
=end
    def starts_with(prefix)
      n = start_with_helper(prefix)
      return !n.nil?
    end

    def start_with_helper(str)
      n = @root
      str.chars.each_with_index do |chr, i|
        #puts "n=#{n}, chr=#{chr}"
        if n.next.has_key?(chr)
          n = n.next[chr]
        else
          return nil
        end
      end

      #puts "helper return n=#{n}"
      return n
    end
end

class Node
  attr_accessor :next, :is_end
  def initialize
    @is_end = false
    @next = {}
  end
end

# Your Trie object will be instantiated and called as such:
# obj = Trie.new()
# obj.insert(word)
# param_2 = obj.search(word)
# param_3 = obj.starts_with(prefix)

describe 'Trie' do
  before (:each) do
    @trie = Trie.new
    @trie.insert('abc')
    @trie.insert('abcd')
    @trie.insert('abcde')

    @trie.insert('bc')
    @trie.insert('bcd')
    @trie.insert('bcde')

    @trie.insert('c')
    @trie.insert('cd')
    @trie.insert('cde')
  end

  it 'search word' do
    @trie.search('abc').must_equal(true)
    @trie.search('abcd').must_equal(true)
    @trie.search('abcde').must_equal(true)

    @trie.search('bc').must_equal(true)
    @trie.search('bcd').must_equal(true)
    @trie.search('bcde').must_equal(true)

    @trie.search('c').must_equal(true)
    @trie.search('cd').must_equal(true)
    @trie.search('cde').must_equal(true)
  end

  it 'should search not exist word' do
    @trie.search('a1bc').must_equal(false)
    @trie.search('a1bcd').must_equal(false)
    @trie.search('a1bcde').must_equal(false)

    @trie.search('b1c').must_equal(false)
    @trie.search('b1cd').must_equal(false)
    @trie.search('b1cde').must_equal(false)

    @trie.search('c1').must_equal(false)
    @trie.search('c1d').must_equal(false)
    @trie.search('c1de').must_equal(false)

    @trie.search('5').must_equal(false)
  end

  it 'should check start with' do
    @trie.starts_with('abc').must_equal(true)
    @trie.starts_with('abcd').must_equal(true)
    @trie.starts_with('abcde').must_equal(true)

    @trie.starts_with('bc').must_equal(true)
    @trie.starts_with('bcd').must_equal(true)
    @trie.starts_with('bcde').must_equal(true)

    @trie.starts_with('c').must_equal(true)
    @trie.starts_with('cd').must_equal(true)
    @trie.starts_with('cde').must_equal(true)

    @trie.starts_with('a1bc').must_equal(false)
    @trie.starts_with('a1bcd').must_equal(false)
    @trie.starts_with('a1bcde').must_equal(false)

    @trie.starts_with('b1c').must_equal(false)
    @trie.starts_with('b1cd').must_equal(false)
    @trie.starts_with('b1cde').must_equal(false)

    @trie.starts_with('c1').must_equal(false)
    @trie.starts_with('c1d').must_equal(false)
    @trie.starts_with('c1de').must_equal(false)

    @trie.starts_with('5').must_equal(false)
  end
end
