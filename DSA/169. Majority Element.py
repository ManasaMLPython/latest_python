# Given an array nums of size n, return the majority element.
#
# The majority element is the element that appears more than ⌊n / 2⌋ times. You may assume that the majority element always exists in the array.
# Example 1:
#
# Input: nums = [3,2,3]
# Output: 3
# Example 2:
#
# Input: nums = [2,2,1,1,1,2,2]
# Output: 2
from collections import Counter
from typing import List


class Solution:
    def majorityElement(self, nums: List[int]) -> int:
        n = len(nums)//2
        for key, val in Counter(nums).items():
            # If an element's count is greater than the threshold, it's the majority element
            if val > n:
                return key


s=Solution()
print(s.majorityElement([2,2,1,1,1,2,2]))
