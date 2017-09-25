require 'minitest/autorun'

# @param {Integer[]} nums
# @return {Integer[][]}
def three_sum(nums)
  nums.sort!
  i = 0
  result = []

  while i < nums.length - 2 do
    if i == 0 || nums[i] != nums[i - 1]
      j = i + 1
      k = nums.length - 1
      #puts "i=#{i}, j=#{j}, k=#{k}"

      while j < k do

        #if j == k - 1 || ((j == i + 1 || nums[j] != nums[j - 1]) && (k == nums.length - 1 || nums[k] != nums[k + 1]))
        if ((j == i + 1 || nums[j] != nums[j - 1]) && (k == nums.length - 1 || nums[k] != nums[k + 1]))
          if nums[i] + nums[j] + nums[k] < 0
            j += 1
          elsif nums[i] + nums[j] + nums[k] > 0
            k -= 1
          else
            #puts "    i=#{i}, j=#{j}, k=#{k}"
            result << [nums[i], nums[j], nums[k]]
            j += 1
            k -= 1
          end
        else
          if nums[j] == nums[j - 1]
            j += 1
          elsif nums[k] == nums[k + 1]
            k += 1
          end
        end

      end
    end
    i += 1
  end

  return result
end

describe 'def three_sum(nums)' do
  it 'should work1' do
    nums = [-1, 0, 1, 2, -1, -4]
    expected_result = [
      [-1, 0, 1],
      [-1, -1, 2]
    ]
    three_sum(nums).sort.must_equal(expected_result.sort)
  end

  it 'should work2' do
    nums = [0,0,0] * 100
    expected_result = [
      [0, 0, 0],
    ]
    three_sum(nums).sort.must_equal(expected_result.sort)
  end
end
