# Given two strings s and t of lengths m and n respectively, return the minimum window
# substring
#  of s such that every character in t (including duplicates) is included in the window. If there is no such substring, return the empty string "".
#
# The testcases will be generated such that the answer is unique.
# Example 1:
# Input: s = "ADOBECODEBANC", t = "ABC"
# Output: "BANC"
# Explanation: The minimum window substring "BANC" includes 'A', 'B', and 'C' from string t.
# Example 2:
# Input: s = "a", t = "a"
# Output: "a"
# Explanation: The entire string s is the minimum window.
# Example 3:
# Input: s = "a", t = "aa"
# Output: ""
# Explanation: Both 'a's from t must be included in the window.
# Since the largest window of s only has one 'a', return empty string.
from collections import Counter


class Solution:
    def minWindow(self, s: str, t: str) -> str:
        # Handle edge cases where 't' is empty or 's' is shorter than 't'
        if t == '':
            return ''
        if len(s) < len(t):
            return ''

        # Initialize pointers and result variables
        r, l = 0, 0
        res = ''

        # Create a frequency count of characters in 't'
        t_hash = Counter(t)
        window_hash = {}

        # Total characters required and current matched count
        need, have = sum(t_hash.values()), 0

        # Initialize the window hash with zero counts for each character in 't'
        for c, co in t_hash.items():
            window_hash[c] = 0

        # Expand the right pointer to include characters in the window
        for r in range(len(s)):
            ch = s[r]
            if ch in t:
                # Increment the count of the character in the window
                window_hash[ch] = 1 + window_hash.get(ch, 0)
                # If this character's count in the window is valid, increase 'have'
                if window_hash[ch] <= t_hash[ch]:
                    have += 1

            # When all characters are matched, try to shrink the window
            while have == need:
                st = s[l:r + 1]
                # Update the result if the current window is smaller
                if len(res) == 0 or len(res) > len(st):
                    res = st

                # Shrink the window from the left
                ch = s[l]
                if ch in window_hash.keys():
                    window_hash[ch] -= 1
                    # If this character's count drops below the required, decrease 'have'
                    if window_hash[ch] < t_hash[ch]:
                        have -= 1
                l += 1

        # Return the smallest valid window
        return res


s = Solution()
print(s.minWindow('bbccacb','ab'))