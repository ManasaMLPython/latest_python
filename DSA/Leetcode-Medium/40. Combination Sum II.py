# Given a collection of candidate numbers (candidates) and a target number (target), find all unique combinations in candidates where the candidate numbers sum to target.
#
# Each number in candidates may only be used once in the combination.
#
# Note: The solution set must not contain duplicate combinations.

from typing import List


class Solution:
    def combinationSum2(self, candidates: List[int], target: int) -> List[List[int]]:
        candidates = sorted(candidates)
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
                for r in res:
                    if r==comb:
                        return

                res.append(list(comb))
                # print('result = ', res)
                return
            if remaining < 0:
                return
            for i in range(start, len(candidates)):
                # remaining = target-num
                num = candidates[i]
                comb.append(num)
                helper(comb, remaining - num, i+1)
                comb.pop()

        helper(comb, target, 0)
        return res

s = Solution()
print(s.combinationSum2([10,1,2,7,6,1,5],8))
