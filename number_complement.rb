require 'minitest/autorun'

# @param {Integer} num
# @return {Integer}
def find_complement(num)
  buffer = []
  while num > 0 do
    buffer << num % 2
    num /= 2
  end
  #puts "buffer=#{buffer}"

  while buffer.last == 0 do
    buffer.pop
  end

  buffer.map! do |val|
    1 - val
  end
  #puts "buffer=#{buffer}"

  sum = 0
  mask = 1

  while !buffer.empty? do
    sum += (buffer.shift * mask)
    #puts "mask=#{mask}"
    #puts "sum=#{sum}"
    mask *= 2
  end

  return sum
end

describe 'find_complement(num)' do
  it 'should work1' do
    num = 5
    expected_results = 2
    find_complement(num).must_equal(expected_results)
    
    num = 1
    expected_results = 0
    find_complement(num).must_equal(expected_results)
  end

  it 'should work2' do
    num = 2
    expected_results = 1
    find_complement(num).must_equal(expected_results)
  end
end
