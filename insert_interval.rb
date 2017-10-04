require 'minitest/autorun'

# Definition for an interval.
class Interval
    attr_accessor :start, :end
    def initialize(s=0, e=0)
        @start = s
        @end = e
    end
end

# @param {Interval[]} intervals
# @param {Interval} new_interval
# @return {Interval[]}
def insert(intervals, new_interval)
  result = []
  from_idx = -1
  from_overlap = nil
  to_idx = -1
  to_overlap = nil

  intervals.each_with_index do |itv, i|
    #puts "itv=#{itv}, start=#{itv.start}, end=#{itv.end}"
    if itv.start <= new_interval.start && itv.end >= new_interval.start
      from_idx = i
      from_overlap = true
    end

    if i == 0 && itv.start > new_interval.start || itv.start > new_interval.start && intervals[i - 1].end < new_interval.start
      from_idx = i
      from_overlap = false
    end


    if itv.start <= new_interval.end && itv.end >= new_interval.end
      to_idx = i
      to_overlap = true
    end

    if i == 0 && itv.start > new_interval.end || itv.start > new_interval.end && intervals[i - 1].end < new_interval.end
      to_idx = i
      to_overlap = false
    end
  end

  if from_idx == -1
    from_idx = intervals.length
    from_overlap = false
  end

  if to_idx == -1
    to_idx = intervals.length
    to_overlap = false
  end

  i = 0
  while i < from_idx do
    result << intervals[i]
    i += 1
  end

  from_val = nil
  if from_overlap
    from_val = intervals[from_idx].start
  else
    from_val = new_interval.start
  end
  #puts "from_idx=#{from_idx}, from_overlap=#{from_overlap}, from_val=#{from_val}"

  to_val = nil
  if to_overlap
    to_val = intervals[to_idx].end
  else
    to_val = new_interval.end
  end

  result << Interval.new(from_val, to_val)

  i = (to_overlap ? 1 : 0) + to_idx
  #puts "i=#{i}"
  while i < intervals.length do
    result << intervals[i]
    i += 1
  end

  return result
end

def itv_to_arr(array)
  return array.map do |itv|
    [itv.start, itv.end]
  end
end

def arr_to_itv(array)
  return array.map do |arr|
    Interval.new(arr[0], arr[1])
  end
end

describe 'insert(intervals, new_interval)' do
  it 'should work1' do
    array = [[1,3],[6,9]]
    intervals = arr_to_itv(array)
    new_interval = Interval.new(2,5)
    result = insert(intervals, new_interval)
    array_result = itv_to_arr(result)
    expected_result = [[1,5],[6,9]]
    array_result.must_equal(expected_result)

    array = [[1,2],[3,5],[6,7],[8,10],[12,16]]
    intervals = arr_to_itv(array)
    new_interval = Interval.new(4,9)
    result = insert(intervals, new_interval)
    array_result = itv_to_arr(result)
    expected_result = [[1,2],[3,10],[12,16]]
    array_result.must_equal(expected_result)
  end

  it 'should work2' do
    array = []
    intervals = arr_to_itv(array)
    new_interval = Interval.new(2,5)
    result = insert(intervals, new_interval)
    puts "result=#{result}"
    array_result = itv_to_arr(result)
    expected_result = [[2,5]]
    array_result.must_equal(expected_result)
  end
end
