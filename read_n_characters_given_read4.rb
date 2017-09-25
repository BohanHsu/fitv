require 'minitest/autorun'

class File
  def initialize(content)
    @content = content
    @buffer = []
    @idx = 0
  end

  def read(arr, n)
    while @buffer.length < n do
      tmp = []
      read4(tmp)
      @buffer += tmp
      if tmp.length < 4
        break
      end
    end
  
    while arr.length < n && !@buffer.empty? do
      arr << @buffer.shift
    end
  
    return arr.length
  end
  
  def read4(arr)
    i = 0
    while i < 4 && @idx < @content.length do
      arr << @content[@idx]
      @idx += 1
      i += 1
    end

    return i
  end
end


describe 'File' do
  before(:each) do
    content = ('a'.ord..'z'.ord).map do |i|
      i.chr
    end.join("")
    @file1 = File.new(content)
    @file2 = File.new("123")
  end

  it 'should read 4 byte by read4' do
    result = []
    returned_value = @file1.read4(result)
    result.join("").must_equal('abcd')
    returned_value.must_equal(4)

    result = []
    returned_value = @file1.read4(result)
    result.join("").must_equal('efgh')
    returned_value.must_equal(4)

    result = []
    returned_value = @file2.read4(result)
    result.join("").must_equal('123')
    returned_value.must_equal(3)

    result = []
    returned_value = @file2.read4(result)
    result.join("").must_equal('')
    returned_value.must_equal(0)
  end

  it 'should read n byte by read' do
    result = []
    returned_value = @file1.read(result, 10)
    result.join("").must_equal('abcdefghij')
    returned_value.must_equal(10)

    result = []
    returned_value = @file1.read(result, 10)
    result.join("").must_equal('klmnopqrst')
    returned_value.must_equal(10)

    result = []
    returned_value = @file1.read(result, 2)
    result.join("").must_equal('uv')
    returned_value.must_equal(2)

    result = []
    returned_value = @file1.read(result, 10)
    result.join("").must_equal('wxyz')
    returned_value.must_equal(4)

    result = []
    returned_value = @file1.read(result, 10)
    result.join("").must_equal('')
    returned_value.must_equal(0)
  end
end
