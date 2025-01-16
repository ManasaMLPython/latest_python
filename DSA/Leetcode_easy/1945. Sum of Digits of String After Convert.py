# You are given a string s consisting of lowercase English letters, and an integer k. Your task is to convert the string into an integer by a special process, and then transform it by summing its digits repeatedly k times. More specifically, perform the following steps:
#
# Convert s into an integer by replacing each letter with its position in the alphabet (i.e. replace 'a' with 1, 'b' with 2, ..., 'z' with 26).
# Transform the integer by replacing it with the sum of its digits.
# Repeat the transform operation (step 2) k times in total.
# For example, if s = "zbax" and k = 2, then the resulting integer would be 8 by the following operations:
#
# Convert: "zbax" ➝ "(26)(2)(1)(24)" ➝ "262124" ➝ 262124
# Transform #1: 262124 ➝ 2 + 6 + 2 + 1 + 2 + 4 ➝ 17
# Transform #2: 17 ➝ 1 + 7 ➝ 8
# Return the resulting integer after performing the operations described above.
# Example 1:
#
# Input: s = "iiii", k = 1
#
# Output: 36
#
# Explanation:
#
# The operations are as follows:
# - Convert: "iiii" ➝ "(9)(9)(9)(9)" ➝ "9999" ➝ 9999
# - Transform #1: 9999 ➝ 9 + 9 + 9 + 9 ➝ 36
# Thus the resulting integer is 36.
#
# Example 2:
#
# Input: s = "leetcode", k = 2
#
# Output: 6
#
# Explanation:
#
# The operations are as follows:
# - Convert: "leetcode" ➝ "(12)(5)(5)(20)(3)(15)(4)(5)" ➝ "12552031545" ➝ 12552031545
# - Transform #1: 12552031545 ➝ 1 + 2 + 5 + 5 + 2 + 0 + 3 + 1 + 5 + 4 + 5 ➝ 33
# - Transform #2: 33 ➝ 3 + 3 ➝ 6
# Thus the resulting integer is 6.
#
# Example 3:
#
# Input: s = "zbax", k = 2
#
# Output: 8
from scipy.stats import alpha


class Solution:
    def getLucky(self, s: str, k: int) -> int:
        # Step 1: Create a new string where each character of 's' is replaced by
        # its corresponding alphabetic position.
        new_str = ''
        for c in s:
            # For each character 'c', find its alphabetic position and append it
            # to 'new_str'. ord(c) returns ASCII value, so subtracting 96
            # maps 'a' to 1, 'b' to 2, ..., 'z' to 26.
            new_str += str(ord(c) - 96)

        # Step 2: Apply the transformation 'k' times
        for _ in range(k):
            total = 0
            for d in new_str:
                total += int(d)
            new_str = str(total)

        return total



s= Solution()
print(s.getLucky('zbax',2))