# Given a collection of numbers, nums, that might contain duplicates, return all
# possible unique permutations in any order.
# Example 1:
#
# Input: nums = [1, 1, 2]
# Output:[[1, 1, 2],[1, 2, 1],[2, 1, 1]]
# Example 2:
#
# Input: nums = [1, 2, 3]
# Output: [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
from typing import List


class Solution:
    def permuteUnique(self, nums: List[int]) -> List[List[int]]:
        result = []
        if len(nums) == 1:
            return [nums[:]]
        for i in range(len(nums)):
            n = nums.pop(0)
            perms = self.permuteUnique(nums)
            for perm in perms:
                perm.append(n)
            nums.append(n)
            for perm in perms:
                if perm not in result:
                    result.extend(perms)
        return result

s = Solution()
print(s.permuteUnique([1,2,1]))