require 'minitest/autorun'

class WordDictionary

  attr_accessor :root
=begin
    Initialize your data structure here.
=end
    def initialize()
        @root = nil
        @empty_string_exist = false
    end


=begin
    Adds a word into the data structure.
    :type word: String
    :rtype: Void
=end
    def add_word(word)
      if word.length == 0
        # handle separately
        @empty_string_exist = true
      end

      prev = nil
      n = @root

      word.chars.each_with_index do |chr, i|
        node = search_node_or_insert_node(n, chr)
        #puts "chr=#{chr}, node=#{node}, letter=#{node.nil? ? '' : node.letter}"

        if node.nil?
          #n is nil, otherwise it will return 
          if prev.nil?
            # root is nil
            @root = Node.new(chr)

            prev = @root
            n = @root.next
            #if i == word.length - 1
            #  prev.is_end = true
            #end
          else
            prev.next = Node.new(chr)
            prev = prev.next
            n = prev.next
            #if i == word.length - 1
            #  prev.is_end = true
            #end
          end
        elsif node.letter == chr
          # I found it
          prev = node
          n = prev.next

          #if i == word.length - 1
          #  prev.is_end = true
          #end
        else
          # I found the insert position
          if chr.ord < node.letter.ord
            # insert to left
            node.left = Node.new(chr)
            prev = node.left
            n = prev.next
          else
            # insert to right
            node.right = Node.new(chr)
            prev = node.right
            n = prev.right
          end

        end

        if i == word.length - 1
          prev.is_end = true
        end
      end
    end

    def search_node_or_insert_node(n, letter)
      #n = @root
      prev = n
      while !n.nil? do
        if letter.ord == n.letter.ord
          return n
        elsif letter.ord < n.letter.ord
          prev = n
          n = n.left
        else
          prev = n
          n = n.right
        end
      end
      return prev
    end


=begin
    Returns if the word is in the data structure. A word could contain the dot character '.' to represent any one letter.
    :type word: String
    :rtype: Boolean
=end
    def search(word)
      #puts "hehe, search(#{word})"
      if word.length == 0
        # handle separately
        return @empty_string_exist
      end

      stack = []

      if word[0] == '.'
        nodes = all_node_in_this_idx(@root)
        nodes.each do |node|
          stack << [node, 0]
        end
      else
        node = search_node_or_insert_node(@root, word[0])
        #puts "node=#{node}, letter=#{node.letter}"
        if !node.nil? && node.letter == word[0]
          stack << [node, 0]
        end
      end

      while !stack.empty? do
        n, idx = stack.pop
        #puts "search, n=#{n}, n.letter=#{n.letter}, idx=#{idx}"

        if idx == word.length - 1
          #puts "maozi"
          if n.is_end
            return true
          end
        else
          #puts "maozi1"
          if word[idx + 1] == '.'

            #puts "maozi2"
            nodes = all_node_in_this_idx(n.next)
            nodes.each do |node|
              stack << [node, idx + 1]
            end
          else
            #puts "maozi3"
            #puts "n.next=#{n.next}"
            #puts "n.next.right=#{n.next.right}"
            node = search_node_or_insert_node(n.next, word[idx + 1])
            #puts "maozi4"
            #puts "node=#{node}, letter=#{node.letter}, idx=#{idx}"
            #puts "#{n.next}"
            if !node.nil? && node.letter == word[idx + 1]
              #puts "xbh"
              stack << [node, idx + 1]
            end
          end
        end
      end

      return false
    end

    def all_node_in_this_idx(root)
      result = []
      if root.nil?
        return result
      end

      queue = [root]

      while !queue.empty? do
        n = queue.shift
        result << n

        if !n.left.nil?
          queue << n.left
        end

        if !n.right.nil?
          queue << n.right
        end
      end

      return result
    end

end


class Node
  attr_accessor :left, :right, :next, :letter, :is_end

  def initialize(letter)
    @letter = letter
    @is_end = false
  end
end


# Your WordDictionary object will be instantiated and called as such:
# obj = WordDictionary.new()
# obj.add_word(word)
# param_2 = obj.search(word)

describe 'WordDictionary' do
  before(:each) do
    @word_dictionary = WordDictionary.new
    @word_dictionary.add_word("abc")
    @word_dictionary.add_word("abcd")

    @word_dictionary.add_word("bc")
    @word_dictionary.add_word("bc")
    @word_dictionary.add_word("bcd")

    @word_dictionary.add_word("c")
    @word_dictionary.add_word("cd")
    #puts @word_dictionary.root.letter
    #puts @word_dictionary.root.next.letter
    #puts @word_dictionary.root.next.next.letter
    #puts @word_dictionary.root.next.next.is_end
    #puts @word_dictionary.root.next.next.next
    #puts @word_dictionary.root.next.next.next.is_end

    #puts @word_dictionary.root.right
    #puts @word_dictionary.root.right.next
    #puts @word_dictionary.root.right.next.next
  end

  it 'should search for matched words' do
    @word_dictionary.search("abc").must_equal(true)
    @word_dictionary.search("abcd").must_equal(true)

    @word_dictionary.search("bc").must_equal(true)
    @word_dictionary.search("bcd").must_equal(true)

    @word_dictionary.search("c").must_equal(true)
    @word_dictionary.search("cd").must_equal(true)
  end

  it 'should search for not exist words' do
    @word_dictionary.search("1abc").must_equal(false)
    @word_dictionary.search("1abcd").must_equal(false)

    @word_dictionary.search("1bc").must_equal(false)
    @word_dictionary.search("1bcd").must_equal(false)

    @word_dictionary.search("1c").must_equal(false)
    @word_dictionary.search("1cd").must_equal(false)

    @word_dictionary.search("a1bc").must_equal(false)
    @word_dictionary.search("a1bcd").must_equal(false)

    @word_dictionary.search("b1c").must_equal(false)
    @word_dictionary.search("b1cd").must_equal(false)

    @word_dictionary.search("c1").must_equal(false)
    @word_dictionary.search("c1d").must_equal(false)
  end

  it 'should search for exist regexp' do
    @word_dictionary.search(".bc").must_equal(true)
    @word_dictionary.search(".bcd").must_equal(true)

    @word_dictionary.search(".c").must_equal(true)
    @word_dictionary.search(".cd").must_equal(true)

    @word_dictionary.search(".").must_equal(true)
    @word_dictionary.search(".d").must_equal(true)

    @word_dictionary.search("a.c").must_equal(true)
    @word_dictionary.search("a.cd").must_equal(true)

    @word_dictionary.search("b.").must_equal(true)
    @word_dictionary.search("b.d").must_equal(true)

    @word_dictionary.search("c.").must_equal(true)
  end
end
