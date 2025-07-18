# You are given an array prices where prices[i] is the price of a given stock on the ith day.
#
# Find the maximum profit you can achieve. You may complete at most two transactions.
#
# Note: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).
# Example 1:
#
# Input: prices = [3,3,5,0,0,3,1,4]
# Output: 6
# Explanation: Buy on day 4 (price = 0) and sell on day 6 (price = 3), profit = 3-0 = 3.
# Then buy on day 7 (price = 1) and sell on day 8 (price = 4), profit = 4-1 = 3.
#
# Example 2:
#
# Input: prices = [1,2,3,4,5]
# Output: 4
# Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
# Note that you cannot buy on day 1, buy on day 2 and sell them later, as you are engaging multiple transactions at the same time. You must sell before buying again.
#
# Example 3:
#
# Input: prices = [7,6,4,3,1]
# Output: 0
# Explanation: In this case, no transaction is done, i.e. max profit = 0.

from typing import List


class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        min_buy = prices[0]
        max1=0
        max2=0
        for price in prices:
            if price<=min_buy:
                min_buy=price
            elif (price-min_buy) > max1:
                max2 = max(max1,max2)
                max1 = price-min_buy
                print(f'price={price}, max1={max1}, max2={max2}, min_buy={min_buy}')

        return max1+max2
s = Solution()
print(s.maxProfit(prices = [3,3,5,0,0,3,1,4]))