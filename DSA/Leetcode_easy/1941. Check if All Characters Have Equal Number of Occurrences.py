# Given a string s, return true if s is a good string, or false otherwise.
#
# A string s is good if all the characters that appear in s have the same number of occurrences (i.e., the same frequency).
# Example 1:
#
# Input: s = "abacbc"
# Output: true
# Explanation: The characters that appear in s are 'a', 'b', and 'c'. All characters occur 2 times in s.
# Example 2:
#
# Input: s = "aaabb"
# Output: false
# Explanation: The characters that appear in s are 'a' and 'b'.
# 'a' occurs 3 times while 'b' occurs 2 times, which is not the same number of times.
from collections import Counter

from collections import Counter


class Solution:
    def areOccurrencesEqual(self, s: str) -> bool:
        # Count the occurrences of each character in the string 's'
        c = Counter(s)

        #maximum frequency
        l = max(c.values())

        for key, val in c.items():
            # If any character has a frequency different from the maximum frequency 'l' return False
            if val != l:
                return False 
        # Step 4: If no mismatched occurrences are found, return True
        return True


s=Solution()
print(s.areOccurrencesEqual(s = "aaabb"))