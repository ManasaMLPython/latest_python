# There is a programming language with only four operations and one variable X:
#
# ++X and X++ increments the value of the variable X by 1.
# --X and X-- decrements the value of the variable X by 1.
# Initially, the value of X is 0.
#
# Given an array of strings operations containing a list of operations, return the final value of X after performing all the operations.
# Example 1:
#
# Input: operations = ["--X","X++","X++"]
# Output: 1
# Explanation: The operations are performed as follows:
# Initially, X = 0.
# --X: X is decremented by 1, X =  0 - 1 = -1.
# X++: X is incremented by 1, X = -1 + 1 =  0.
# X++: X is incremented by 1, X =  0 + 1 =  1.
from typing import List


class Solution:
    def finalValueAfterOperations(self, operations: List[str]) -> int:
        val=0
        for c in operations:
            if c=='--X' or c=='X--':
                val-=1
            else:
                val+=1
        return val


s=Solution()
print(s.finalValueAfterOperations(operations = ["--X","X++","X++"]))