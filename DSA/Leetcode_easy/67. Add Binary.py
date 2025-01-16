# Given two binary strings a and b, return their sum as a binary string.
# Example 1:
#
# Input: a = "11", b = "1"
# Output: "100"
# Example 2:
#
# Input: a = "1010", b = "1011"
# Output: "10101"

class Solution:
    def addBinary(self, a: str, b: str) -> str:
        total = int(a,2)+int(b,2)
        binary_sum =''
        if total==0:
            return '0'
        while total>0:
            b = total%2
            binary_sum=str(b)+binary_sum
            total=total//2
        return binary_sum

s= Solution()
print(s.addBinary(a="11", b = "1"))