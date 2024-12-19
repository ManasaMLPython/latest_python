from typing import List

class Solution:
    def combinationSum(self, candidates: List[int], target: int) -> List[List[int]]:
        if len(candidates) == 1:
            if candidates[0] == target:
                return [candidates]
            else:
                return []
        res = []
        comb = []
        remaining = target

        # start = 0
        def helper(comb, remaining, start):
            if remaining == 0:
                res.append(list(comb))
                # print('result = ', res)
                return
            if remaining < 0:
                return
            for i in range(start, len(candidates)):
                # remaining = target-num
                num = candidates[i]
                comb.append(num)
                helper(comb, remaining - num, i)
                comb.pop()

        helper(comb, target, 0)
        return res

s = Solution()
print(s.combinationSum([10,1,2,7,6,1,5],8))
