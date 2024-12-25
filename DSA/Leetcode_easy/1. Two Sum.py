# Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
#
# You may assume that each input would have exactly one solution, and you may not use the same element twice.
#
# You can return the answer in any order.
# Example 1:
#
# Input: nums = [2,7,11,15], target = 9
# Output: [0,1]
# Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
# Example 2:
#
# Input: nums = [3,2,4], target = 6
# Output: [1,2]
# Example 3:
#
# Input: nums = [3,3], target = 6
# Output: [0,1]
from typing import List


class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        hash_map = {}
        res = []
        for index,value in enumerate(nums):
            difference = target-value
            if difference in hash_map:
                return [index, hash_map[difference]]
            hash_map[difference] = index
        return res


s = Solution()
print(s.twoSum([2,5,6,11],10))

# O(n2)solution
# class Solution:
#     def twoSum(self, nums: List[int], target: int) -> List[int]:
#         def helper(nums,target,start):
#             for i in range(start+1,len(nums)):
#                 print(nums[i]+nums[start])
#                 if nums[i]+nums[start]==target:
#                     return [start,i]
#             return helper(nums,target,start+1)
#
#         return helper(nums,target,0)
