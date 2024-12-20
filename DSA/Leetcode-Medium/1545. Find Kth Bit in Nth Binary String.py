# Given two positive integers n and k, the binary string Sn is formed as follows:
#
# S1 = "0"
# Si = Si - 1 + "1" + reverse(invert(Si - 1)) for i > 1
# Where + denotes the concatenation operation, reverse(x) returns the reversed string x, and invert(x) inverts all the bits in x (0 changes to 1 and 1 changes to 0).
#
# For example, the first four strings in the above sequence are:
# S1 = "0"
# S2 = "011"
# S3 = "0111001"
# S4 = "011100110110001"
# Return the kth bit in Sn. It is guaranteed that k is valid for the given n.

# Example 1:
# Input: n = 3, k = 1
# Output: "0"
# Explanation: S3 is "0111001".
# The 1st bit is "0".

# Example 2:
# Input: n = 4, k = 11
# Output: "1"
# Explanation: S4 is "011100110110001".
# The 11th bit is "1".

class Solution:
    def findKthBit(self, n: int, k: int) -> str:
        if n == 1:  # Base case
            return '0'

        left = 1  # Left boundary
        right = (2 ** n) - 1  # Right boundary
        for _ in range(n):
            mid = (left + right) // 2
            if k == mid:  # If k is at the middle, return '1'
                return '1'

            if k < mid:  # If k is in the left half find bit at n-1 string
                return self.findKthBit(n - 1, k)

            if k > mid:  # If k is in the right half
                # find the k equivalent bit in first half and flip the result
                length = (2 ** n) - 1  # Calculate the total length of the current string
                dist_k = length - k  # Calculate the mirrored position of k in the left half
                k = left + dist_k
                res = self.findKthBit(n - 1, k)
                return '0' if res == '1' else '1'  # Flip the bit


s = Solution()
print(s.findKthBit(4,15))
