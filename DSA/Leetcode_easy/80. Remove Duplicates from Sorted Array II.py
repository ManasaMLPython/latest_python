# Given an integer array nums sorted in non-decreasing order, remove some duplicates in-place such that each unique element appears at most twice. The relative order of the elements should be kept the same.
#
# Since it is impossible to change the length of the array in some languages, you must instead have the result be placed in the first part of the array nums. More formally, if there are k elements after removing the duplicates, then the first k elements of nums should hold the final result. It does not matter what you leave beyond the first k elements.
#
# Return k after placing the final result in the first k slots of nums.
#
# Do not allocate extra space for another array. You must do this by modifying the input array in-place with O(1) extra memory.
# Example1:
#
# Input: nums = [1, 1, 1, 2, 2, 3]
# Output: 5, nums = [1, 1, 2, 2, 3, _,_]
#
# Example 2:
#
# Input: nums = [0,0,1,1,1,1,2,3,3]
# Output: 7, nums = [0,0,1,1,2,3,3,_,_]
from typing import List


class Solution:
    def removeDuplicates(self, nums: List[int]) -> int:
        p1=0
        p2=0
        count=0
        while p2<len(nums):
            if nums[p2]==nums[p1]:
                count+=1
                if count==2:
                    p1+=1
                    nums[p1] = nums[p2]
            else:
                p1+=1
                count=1
                nums[p1]=nums[p2]
            p2+=1
        return p1+1


s = Solution()
print(s.removeDuplicates(nums = [1,1,1,2,2,3]))

