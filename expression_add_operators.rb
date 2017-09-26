require 'minitest/autorun'

# @param {String} num
# @param {Integer} target
# @return {String[]}
def add_operators(num, target)
  result = []
  return result if num.length == 0
  if num[0] == "0"
    to = 1
    str = num[0...to]
    val = str.to_i
    helper(str, num, to, target, val, val, "+", result)
  else
    (1..num.length).each do |to|
      str = num[0...to]
      val = str.to_i
      helper(str, num, to, target, val, val, "+", result)
    end
  end

  return result
end

def helper(expression, num, from, target, cur_val, last_val, last_operator, result)
  #puts "helper(expression=#{expression}, from=#{from}, cur_val=#{cur_val}, last_val=#{last_val}, last_operator=#{last_operator})"
  if from == num.length 
    if target == cur_val
      result << expression
    end
  end

  if num[from] == '0'
    i = from + 1
    str = num[from...i]
    val = str.to_i
    helper(expression + "+" + str, num, i, target, cur_val + val, val, "+", result)
    helper(expression + "-" + str, num, i, target, cur_val - val, val, "-", result)
    helper(expression + "*" + str, num, i, target, (last_operator == "+" ? (cur_val - last_val + last_val * val) : (cur_val + last_val - last_val * val)), val * last_val, last_operator, result)
  else
    ((from+1)..num.length).each do |i|
      str = num[from...i]
      val = str.to_i

      helper(expression + "+" + str, num, i, target, cur_val + val, val, "+", result)
      helper(expression + "-" + str, num, i, target, cur_val - val, val, "-", result)
      helper(expression + "*" + str, num, i, target, (last_operator == "+" ? (cur_val - last_val + last_val * val) : (cur_val + last_val - last_val * val)), val * last_val, last_operator, result)
    end
  end
end

describe 'add_operators(num, target)' do
  it 'should work1' do
    num = "123"
    target = 15
    expected_result = ["12+3"] 
    add_operators(num, target).sort.must_equal(expected_result.sort)

    num = "123"
    target = 6
    expected_result = ["1+2+3", "1*2*3"] 
    add_operators(num, target).sort.must_equal(expected_result.sort)

    num = "232"
    target = 8
    expected_result = ["2*3+2", "2+3*2"]
    add_operators(num, target).sort.must_equal(expected_result.sort)

    num = "105"
    target = 5
    expected_result = ["1*0+5","10-5"]
    add_operators(num, target).sort.must_equal(expected_result.sort)

    num = "00"
    target = 0
    expected_result = ["0+0", "0-0", "0*0"]
    add_operators(num, target).sort.must_equal(expected_result.sort)

    num = "3456237490"
    target = 9191
    expected_result = []
    add_operators(num, target).sort.must_equal(expected_result.sort)
  end

  it 'should work2' do
    num = "00"
    target = 0
    expected_result = ["0+0", "0-0", "0*0"]
    add_operators(num, target).sort.must_equal(expected_result.sort)
  end
end
