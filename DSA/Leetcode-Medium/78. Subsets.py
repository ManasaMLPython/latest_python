# Given two integers n and k, return all possible combinations of k numbers chosen from
# the range [1, n].
# You may return the answer in any order.
from typing import List


class Solution:
    def subsets(self, nums: List[int]) -> List[List[int]]:
        res = []
        comb=[]
        def helper(comb,index):
            if len(comb)>len(nums):
                return
            else:
                res.append(list(comb))
            for i in range(index,len(nums)):
                num = nums[i]
                comb.append(num)
                helper(comb,i+1)
                comb.pop()

        helper(comb,0)
        return res

s = Solution()
print(s.subsets([1,2,3]))
