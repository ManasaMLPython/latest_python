# Given an array nums of distinct integers, return all the possible
# permutations
# . You can return the answer in any order.
from typing import List


# Example 1:
#
# Input: nums = [1,2,3]
# Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
# Example 2:
#
# Input: nums = [0,1]
# Output: [[0,1],[1,0]]
# Example 3:
#
# Input: nums = [1]
# Output: [[1]]
class Solution:
    def permute(self, nums: List[int]) -> List[List[int]]:
        result = []

        # Base case: If only one number remains, return it as the only permutation
        if len(nums) == 1:
            return [nums[:]]  # Use a shallow copy to avoid modifying the original list

        for i in range(len(nums)):
            # Remove the first element and store it in `n`
            n = nums.pop(0)

            # Recursively find permutations for the remaining numbers
            perms = self.permute(nums)

            # append the removed element `n` back to each permutation
            for perm in perms:
                perm.append(n)

            # Restore the removed element `n` back to `nums`
            nums.append(n)

            # Extend the result list with all newly formed permutations
            result.extend(perms)

        return result


s = Solution()
print(s.permute([1, 2, 3]))
