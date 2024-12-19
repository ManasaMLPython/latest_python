# Given an integer n, return true if it is a power of two. Otherwise, return false.
# An integer n is a power of two, if there exists an integer x such that n == 2x.
# Input: n = 1
# Output: true
# Explanation: 2 power 0 = 1
# Input: n = 16
# Output: true
# Explanation: 2 power 4 = 16
# Input: n = 3
# Output: false

class Solution:
    def isPowerOfTwo(self, n: int) -> bool:
        return n>0 and (n&(n-1))==0


s = Solution()
print(s.isPowerOfTwo(3))
