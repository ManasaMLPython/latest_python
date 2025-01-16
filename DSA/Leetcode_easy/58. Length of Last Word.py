# Given a string s consisting of words and spaces, return the length of the last word in the string.
#
# A word is a maximal
# substring
#  consisting of non-space characters only.
# Example 1:
#
# Input: s = "Hello World"
# Output: 5
# Explanation: The last word is "World" with length 5.
# Example 2:
#
# Input: s = "   fly me   to   the moon  "
# Output: 4
# Explanation: The last word is "moon" with length 4.
# Example 3:
#
# Input: s = "luffy is still joyboy"
# Output: 6
# Explanation: The last word is "joyboy" with length 6.
class Solution:
    def lengthOfLastWord(self, s: str) -> int:
        if len(s) == 0:
            return 0

        end = -1

        # to track length of last word
        l = 0

        # First, move the `end` pointer to skip trailing spaces, if any
        while s[end] == ' ':
            end -= 1
        while end >= -len(s):
            # If we encounter a space, the last word has ended, so return its length
            if s[end] == ' ':
                return l
            else:
                # If it's part of a word, increase the length of the last word
                end -= 1
                l += 1

        return l


s=Solution()
print(s.lengthOfLastWord("a"))