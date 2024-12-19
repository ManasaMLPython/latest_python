# Given two integers n and k, return all possible combinations of k numbers chosen from
# the range [1, n].
# You may return the answer in any order.
from typing import List


class Solution:
    def combine(self, n: int, k: int) -> List[List[int]]:
        nums = [k for k in range(1,n+1)]
        res = []
        comb=[]
        def helper(comb,index):
            if len(comb)==k:
                res.append(list(comb))
                return
            for i in range(index,len(nums)):
                num = nums[i]
                comb.append(num)
                helper(comb,i+1)
                comb.pop()

        helper(comb,0)
        return res

s = Solution()
print(s.combine(1,1))
