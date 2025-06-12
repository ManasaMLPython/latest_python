# Given two non-negative integers num1 and num2 represented as strings, return the product of num1 and num2, also represented as a string.
#
# Note: You must not use any built-in BigInteger library or convert the inputs to integer directly.
# Example 1:
#
# Input: num1 = "2", num2 = "3"
# Output: "6"
# Example 2:
#
# Input: num1 = "123", num2 = "456"
# Output: "56088"

class Solution(object):
    def multiply(self, num1, num2):
        """
        :type num1: str
        :type num2: str
        :rtype: str
        """
        =DATEDIF(J2,TODAY())
        def str_to_int(ch):
            result = 0
            for c in ch:
                temp = ord(c) - ord('0')
                result = result*10 + temp
            return result
        def int_to_str(prod):
            char_digits = []
            while prod>0:
                j = prod%10
                char_digits.insert(0,chr(ord('0')+j))
                prod = prod // 10
            return ''.join(char_digits)
        num1 = str_to_int(num1)
        num2 = str_to_int(num2)
        product = num1*num2
        return int_to_str(product)

s = Solution()
print(s.multiply("0","0"))