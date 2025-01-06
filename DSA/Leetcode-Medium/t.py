from logging import lastResort
from typing import List



class Solution:
    def rotate(self, nums: List[int], k: int) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        t = nums[k:len(nums)-k]
        nums = nums[:k]+nums[len(nums)-k:]
        print(nums)
        first=0
        last = len(nums)//2
        print(nums[first],nums[last])
        while last<len(nums):
            temp = nums[first]
            nums[first]=nums[last]
            nums[last]=temp
            first+=1
            last+=1
        nums+=t
        print(nums)
s = Solution()
s.rotate(nums = [1,2,3,4,5,6,7], k = 3)
