# Given a string s and an array of strings words, determine whether s is a prefix string of words.
#
# A string s is a prefix string of words if s can be made by concatenating the first k strings in words for some positive k no larger than words.length.
#
# Return true if s is a prefix string of words, or false otherwise.
# Example 1:
#
# Input: s = "iloveleetcode", words = ["i","love","leetcode","apples"]
# Output: true
# Explanation:
# s can be made by concatenating "i", "love", and "leetcode" together.
# Example 2:
#
# Input: s = "iloveleetcode", words = ["apples","i","love","leetcode"]
# Output: false
# Explanation:
# It is impossible to make s using a prefix of arr.
from typing import List


class Solution:
    def isPrefixString(self, s: str, words: List[str]) -> bool:
        # `start` to track the current position in `s`
        # `i` to iterate over `words`.
        start = 0
        i = 0

        while i < len(words) and start < len(s):
            # Check if the current word matches the substring of `s` starting from `start`.
            if words[i] != s[start:start + len(words[i])]:
                return False

            # Update `start` to move past the current word in `s`.
            start += len(words[i])
            i += 1

        # After the loop, check if the whole string `s` has been covered.
        if start < len(s):
            return False  # If there are remaining characters in `s`, return False.
        else:
            return True


s=Solution()
print(s.isPrefixString(s = "iloveleetcode", words = ["i","love","leetcode","apples"]))