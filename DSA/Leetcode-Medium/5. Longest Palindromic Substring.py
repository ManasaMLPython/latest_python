# Given a string s, return the longest  palindromic substring in s.
# Example 1:
#
# Input: s = "babad"
# Output: "bab"
# Explanation: "aba" is also a valid answer.
# Example 2:
#
# Input: s = "cbbd"
# Output: "bb"

class Solution:
    def longestPalindrome(self, s: str) -> str:
        # Base case:
        if len(s) == 0 or len(s) == 1:
            return s

        long_pali = ''
        long_len = 0

        for i in range(len(s)):
            # odd-length palindromes
            l = i
            r = i

            while l >= 0 and r < len(s) and s[l] == s[r]:
                # If the current palindrome is longer than the previous longest one, update it
                if long_len < r - l + 1:
                    long_pali = s[l:r + 1]
                    long_len = r - l + 1
                l -= 1
                r += 1

            #even-length palindromes
            l = i
            r = i + 1
            while l >= 0 and r < len(s) and s[l] == s[r]:
                if long_len < r - l + 1:
                    long_pali = s[l:r + 1]
                    long_len = r - l + 1  #
                l -= 1
                r += 1 
        return long_pali


s=Solution()
print(s.longestPalindrome('aacabdkacaa'))