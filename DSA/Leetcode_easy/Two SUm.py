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



class Solution(object):
    def twoSum(self, nums, target):

        result = {}
        for index, val in enumerate(nums):
            difference = target-val
            if difference in result:
                return [result[difference], index]
            result[val] = index


s= Solution()
print(s.twoSum([3,2,4],6))
