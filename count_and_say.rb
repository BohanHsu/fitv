require 'minitest/autorun'

# @param {Integer} n
# @return {String}
def count_and_say(n)
  str = "1"
  (n - 1).times do
    str = helper(str)
  end

  return str
end

def helper(str)
  result = []
  chrs = str.chars
  last_digit = chrs[0]
  cnt = 0
  i = 0

  while i < chrs.length do
    if chrs[i] == last_digit
      cnt += 1
    else
      result << cnt.to_s
      result << last_digit
      last_digit = chrs[i]
      cnt = 1
    end
    i += 1
  end
  result << cnt.to_s
  result << last_digit
  return result.join("")
end

describe 'count_and_say(n)' do
  it 'should work1' do
    arr = [
      "1",
     "11",
     "21",
     "1211",
     "111221"
    ]
    arr.each_with_index do |expected_result, i|
      count_and_say(i + 1).must_equal(expected_result)
    end
  end
end
