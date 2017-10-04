require 'minitest/autorun'

# @param {Integer[]} nums
# @return {Integer}
def longest_consecutive(nums)
  max = 0
  map = {}
  nums.each do |num|
    map[num] = true
  end

  map.keys.each do |k|
    cnt = 0
    i = k
    while map.has_key?(i) && map[i] do
      cnt += 1
      map[i] = false
      i += 1
    end

    i = k - 1
    while map.has_key?(i) && map[i] do
      cnt += 1
      map[i] = false
      i -= 1
    end

    if cnt > max
      max = cnt
    end
  end

  return max
end

describe 'longest_consecutive(nums)' do
  it 'should work1' do
    nums = [100, 4, 200, 1, 3, 2]
    expected_result = 4
    longest_consecutive(nums).must_equal(expected_result)

    nums = []
    expected_result = 0
    longest_consecutive(nums).must_equal(expected_result)
  end
end
