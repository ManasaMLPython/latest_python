# Given an integer rowIndex, return the rowIndexth (0-indexed) row of the Pascal's triangle.
#
# In Pascal's triangle, each number is the sum of the two numbers directly above it as shown:
# Example 1:
#
# Input: rowIndex = 3
# Output: [1,3,3,1]
# Example 2:
#
# Input: rowIndex = 0
# Output: [1]
# Example 3:
#
# Input: rowIndex = 1
# Output: [1,1]

from typing import List


class Solution:
    def getRow(self, rowIndex: int) -> List[int]:
        res = [1]
        for i in range(rowIndex):
            nxt = [0]*(len(res)+1)
            for j in range(len(res)):
                nxt[j] += res[j]
                nxt[j+1]+=res[j]
            res=nxt
        return res


s = Solution()
print(s.getRow(3))