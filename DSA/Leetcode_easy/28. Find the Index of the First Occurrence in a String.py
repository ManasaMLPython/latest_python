# Given two strings needle and haystack, return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.
# Example 1:
#
# Input: haystack = "sadbutsad", needle = "sad"
# Output: 0
# Explanation: "sad" occurs at index 0 and 6.
# The first occurrence is at index 0, so we return 0.
# Example 2:
#
# Input: haystack = "leetcode", needle = "leeto"
# Output: -1
# Explanation: "leeto" did not occur in "leetcode", so we return -1.
class Solution:
    def strStr(self, haystack: str, needle: str) -> int:
        # If the needle is longer than the haystack return -1
        if len(haystack) < len(needle):
            return -1

        # start and end indices for the current substring in haystack
        start = 0
        end = len(needle) - 1

        while end < len(haystack):
            # If the current substring in haystack matches the needle return start index
            if haystack[start:end + 1] == needle:
                return start
            else:
                # If there's no match, move the window one character to the right
                start += 1
                end += 1

        # If no match was found, return -1
        return -1


s= Solution()
print(s.strStr(haystack = "mississippi", needle = "issip"))