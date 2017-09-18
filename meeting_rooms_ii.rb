require 'minitest/autorun'
def num_of_rooms(meetings)
  meetings.sort! do |x, y|
    if x[0] < y[0]
      compare = -1
    elsif x[0] > y[0]
      compare = 1
    elsif x[1] > y[1]
      compare = -1
    elsif x[1] < y[1]
      compare = 1
    else
      compare = 0
    end
    compare
  end

  cur_cnt = 0
  max_cnt = 0
  i = 0
  while i < meetings.length do
    stack = [meetings[i]]
    j = i + 1
    while !stack.empty? do
      if j < meetings.length && overlap(meetings[j], stack.last)
        stack << overlapped_range(meetings[j], stack.last)
        if stack.length > max_cnt
          max_cnt = stack.length
        end
        j += 1
      else
        stack.pop
      end
    end

    i = j
  end
  return max_cnt
end

def overlap(tr1, tr2)
  return !(tr1[0] >= tr2[1] || tr1[1] <= tr2[0])
end

def overlapped_range(tr1, tr2)
  return [[tr1[0], tr1[0]].max, [tr1[1], tr2[1]].min]
end

describe 'num_of_rooms(meetings)' do
  it 'should work1' do
    meetings = [[0, 30],[5, 10],[15, 20]]
    expected_result = 2
    num_of_rooms(meetings).must_equal(expected_result)
  end
end
