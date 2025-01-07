# Given an integerbarray nums, rotate the array to the right by k steps, where
# k is non - negative.
#
# Example 1:
#
# Input: nums = [1, 2, 3, 4, 5, 6, 7], k = 3
# Output: [5, 6, 7, 1, 2, 3, 4]
#
# Example 2:
#
# Input: nums = [-1, -100, 3, 99], k = 2
# Output: [3, 99, -1, -100]

from typing import List



class Solution:
    def rotate(self, nums: List[int], k: int) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        # Calculate the effective number of rotations
        # If k > len(nums), rotating by k is equivalent to rotating by k % len(nums).
        k = k % len(nums)

        # Reverse the entire array
        nums.reverse()

        # Reverse the first k elements to bring them to their correct order
        nums[:k] = reversed(nums[:k])

        # Reverse the remaining elements to bring them to their correct order
        nums[k:] = reversed(nums[k:])

s = Solution()
s.rotate(nums = [1,2], k = 3)
