import math


class Solution:
    def isPowerOfFour(self, n: int) -> bool:
        return n>0 and n%3==1 and (n & (n-1))==0

    def isPowerOfFour1(self, n: int) -> bool:
        return (math.log(n,4)).is_integer()
s= Solution()
print(s.isPowerOfFour(5))
print(s.isPowerOfFour1(16))