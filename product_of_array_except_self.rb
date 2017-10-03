require 'minitest/autorun'

# @param {Integer[]} nums
# @return {Integer[]}
def product_except_self(nums)

  cnt = nums.select do |val|
    val == 0
  end.length

  if cnt == 0
    prod = nums.inject(1) do |memo, obj|
      memo * obj
    end

    return nums.map do |val|
      prod / val
    end
  end

  if cnt == 1
    prod = nums.inject(1) do |memo, obj|
      memo * (obj == 0 ? 1 : obj)
    end

    return nums.map do |val|
      val == 0 ? prod : 0
    end
  end

  if cnt >= 2
    return nums.map do
      0
    end
  end
end

describe 'product_except_self(nums)' do
  it 'should work1' do
    nums = [1,2,3,4]
    expected_result = [24,12,8,6]
    product_except_self(nums).must_equal(expected_result)
  end
end
