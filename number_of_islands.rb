require 'minitest/autorun'

# @param {Character[][]} grid
# @return {Integer}
def num_islands(grid)
  return 0 if grid.empty?
  height = grid.length
  width = grid[0].length
  count = 0

  height.times do |i|
    width.times do |j|
      if grid[i][j] == "1"
        count += 1
        #puts "i=#{i}, j=#{j}, grid[i][j]=#{grid[i][j]}"
        queue = [[i, j]]
        while !queue.empty? do
          a, b = queue.shift
          if grid[a][b] == "1"
            grid[a][b] = "0"
            if a > 0 && grid[a-1][b] == "1"
              queue << [a-1, b]
            end
            if a < height - 1 && grid[a+1][b] == "1"
              queue << [a+1, b]
            end
            if b > 0 && grid[a][b-1] == "1"
              queue << [a, b-1]
            end
            if b < width - 1 && grid[a][b+1] == "1"
              queue << [a, b+1]
            end
          end
        end
      end
    end
  end
  return count
end

describe 'num_islands(grid)' do
  it 'should work1' do
    grid = ["11110".split(""),
            "11010".split(""),
            "11000".split(""),
            "00000".split("")]
    expected_result = 1
    num_islands(grid).must_equal(expected_result)

    grid = ["11000".split(""),
            "11000".split(""),
            "00100".split(""),
            "00011".split("")]
    expected_result = 3
    num_islands(grid).must_equal(expected_result)
  end
end
