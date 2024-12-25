# Given an integer numRows, return the first numRows of Pascal's triangle.
#
# In Pascal's triangle, each number is the sum of the two numbers directly above it
#
# Example 1:
#
# Input: numRows = 5
# Output: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]]
# Example 2:
#
# Input: numRows = 1
# Output: [[1]]
from typing import List


class Solution:
    def generate(self, numRows: int) -> List[List[int]]:
        res = []  # Pascal's Triangle.

        def helper(n, r):
            # Base case for the first row:
            if n == 1:
                return [1]
            # Base case for the second row:
            if n == 2:
                return [1, 1]

            t=[]

            # Fill in the middle values for the current row.
            for i in range(1, n - 1):
                # Sum of the two elements above the current position in the previous row.
                t.append(r[n - 2][i - 1] + r[n - 2][i])

            return [1]+t+[1]  # Return the completed row by appending 1 at front and last since in pascal
                              # triangle each row starts and ends with 1 .

        # Generate each row and add it to the result list.
        for i in range(1, numRows + 1):
            res.append(helper(i, res))

        return res


s = Solution()
print(s.generate(5))
