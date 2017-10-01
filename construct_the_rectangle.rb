require 'minitest/autorun'

# @param {Integer} area
# @return {Integer[]}
def construct_rectangle(area)
  sr = mysqrt(area)
  i = sr
  while area % i != 0 do
    i += 1
  end

  return [i, area / i].sort.reverse
end

# the int of mysqrt root of number
def mysqrt(num)
  return 0 if num == 0
  return 1 if num == 1
  from = 0
  to = num
  sr = (from + to) / 2

  while !(sr ** 2 == num  || (sr ** 2 < num && (sr + 1) ** 2 > num)) do
    sr = (from + to) / 2
    if sr ** 2 == num  || (sr ** 2 < num && (sr + 1) ** 2 > num)
      # can't happen
    elsif sr ** 2 > num
      to = sr
    else
      from = sr
    end
  end

  return sr
end

describe 'mysqrt(num)' do
  it 'should work1' do
    (0...1000).each do |i|
      #puts "i=#{i}"
      mysqrt(i).must_equal(Math.sqrt(i).to_i)
    end
  end
end

describe 'construct_rectangle(area)' do
  it 'should work2' do
    area = 4
    expected_result = [2, 2]
    construct_rectangle(area).must_equal(expected_result)
  end
end
