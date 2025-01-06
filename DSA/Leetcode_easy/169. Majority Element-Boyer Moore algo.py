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
        count, candidate = 0, None
        for num in nums:
            if count==0:
                candidate=num
            count+=1 if candidate==num else -1
        return candidate


s=Solution()
print(s.majorityElement([2,2,1,1,1,2,2]))
