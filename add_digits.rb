require 'minitest/autorun'

# @param {Integer} num
# @return {Integer}
def add_digits(num)
  if num < 10
    return num
  else

    sum = 0
    while num > 0 do
      sum += num % 10
      num /= 10
    end

    return add_digits(sum)
  end
end

describe 'add_digits(num)' do
  it 'should work1' do
    num = 83
    expected_result = 2
    add_digits(num).must_equal(expected_result)
  end
end
