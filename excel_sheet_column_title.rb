require 'minitest/autorun'

# @param {Integer} n
# @return {String}
def convert_to_title(n)
  result = []

  while n > 0 do
    result << n % 26
    n /= 26
  end

  result.each_with_index do |val, i|
    if val == 0 && i < result.length - 1
      result[i + 1] -= 1
      result[i] = 26
    end
  end
  #p result

  result.select! do |val|
    val != 0
  end
  #p result

  result.map! do |val|
    #(val == 0 ? 'Z' : (val + 'A'.ord - 1).chr)
    (val + 'A'.ord - 1).chr
  end

  return result.reverse.join("")
end

describe 'convert_to_title(n)' do
  it 'should work1' do
    n = 26
    expected_result = "Z"
    convert_to_title(n).must_equal(expected_result)

    n = 27
    expected_result = "AA"
    convert_to_title(n).must_equal(expected_result)

    n = 28
    expected_result = "AB"
    convert_to_title(n).must_equal(expected_result)
  end
end

