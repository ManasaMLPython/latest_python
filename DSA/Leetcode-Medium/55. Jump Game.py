# You are given an integer array nums. You are initially positioned at the array's first index, and each element in the array represents your maximum jump length at that position.
#
# Return true if you can reach the last index, or false otherwise.
# Example 1:
#
# Input: nums = [2,3,1,1,4]
# Output: true
# Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.
# Example 2:
#
# Input: nums = [3,2,1,0,4]
# Output: false
# Explanation: You will always arrive at index 3 no matter what. Its maximum jump length is 0, which makes it impossible to reach the last index.
from typing import List


class Solution:
    def canJump(self, nums: List[int]) -> bool:
        max_reach=0
        for i in range(len(nums)):
            # If we cannot reach this index, return False.
            if i>max_reach:
                return False
            # Update the max jump index at each step.
            max_reach=max(max_reach,i+nums[i])
            # If we can reach the last index, return True.
            if max_reach>=len(nums)-1:
                return True
        return False

s= Solution()
print(s.canJump([2,0,0,5]))