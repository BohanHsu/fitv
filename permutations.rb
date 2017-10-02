require 'minitest/autorun'

# @param {Integer[]} nums
# @return {Integer[][]}
def permute(nums)
  #puts "permute(#{nums})"
  indexes = permute_helper(nums.length)

  result = indexes.map do |row|
    row.map do |val|
      nums[val]
    end
  end

  return result
end

def permute_helper(n)
  if n == 0
    return []
  elsif n == 1
    return [[0]]
  end

  result = []

  base = permute_helper(n-1)

  n.times do |i|
    base.each do |b|
      tmp = b.clone
      tmp.insert(i, n - 1)
      result << tmp
    end
  end
  return result
end

describe 'permute(nums)' do
  it 'should work1' do
    nums = [1,2,3]
    expected_result = [
      [1,2,3],
      [1,3,2],
      [2,1,3],
      [2,3,1],
      [3,1,2],
      [3,2,1]
    ]
    #puts "nums=#{nums}"
    permute(nums)
    #permute(nums).sort.must_equal(expected_result.sort)
  end
end
