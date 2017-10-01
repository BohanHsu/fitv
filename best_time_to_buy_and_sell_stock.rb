require 'minitest/autorun'

# @param {Integer[]} prices
# @return {Integer}
def max_profit(prices)
  j = 0
  i = 1
  max_profit = 0
  min_price_idx = 0

  while i < prices.length do
    if prices[i] - prices[min_price_idx] > max_profit
      max_profit = prices[i] - prices[min_price_idx]
    end

    if prices[i] < prices[min_price_idx]
      min_price_idx = i
    end
    
    i += 1
  end

  return max_profit
end

describe 'max_profit(prices)' do
  it 'should work1' do
    prices = [7, 1, 5, 3, 6, 4]
    expected_result = 5
    max_profit(prices).must_equal(expected_result)

    prices = [7, 6, 4, 3, 1]
    expected_result = 0
    max_profit(prices).must_equal(expected_result)
  end
end
