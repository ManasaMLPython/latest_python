#The Fibonacci numbers, commonly denoted F(n) form a sequence, called the Fibonacci sequence,
# such that each number is the sum of the two preceding ones, starting from 0 and 1.
from matplotlib.pyplot import fill_between


class Solution:
    def fib(self, n: int) -> int:
        f = 0
        def fibonnacci(n):
            if n<=1:
                return n
            return fibonnacci(n-1)+fibonnacci(n-2)
        for i in range(n+1):
            f=fibonnacci(i)
        return f


s = Solution()
print(s.fib(2))

# class Solution:
#     def fib(self, n: int) -> int:
#         if n<=1:
#             return n
#         a,b=0,1
#         for _ in range(2,n+1):
#             a,b = b, a+b
#         return b



