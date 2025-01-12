# Given a string s, find the length of the longest substring without repeating characters.
# Example 1:
#
# Input: s = "abcabcbb"
# Output: 3
# Explanation: The answer is "abc", with the length of 3.
# Example2:
#
# Input: s = "bbbbb"
# Output: 1
# Explanation: The answer is "b", with the length of 1.
# Example 3:
#
# Input: s = "pwwkew"
# Output: 3
# Explanation: Theanswer is "wke",with the length of 3.Notice that the answer must be a substring, "pwke" is a
# subsequence and not a substring.
class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        # Edge case
        if len(s) == 0 or len(s) == 1:
            return len(s)

        # Two pointers for the sliding window, and a dictionary to track characters.
        start = 0
        end = 0
        dic = {}
        max_length = 0
        # Step 3: Iterate through the string using p2 as the right pointer.
        while end < len(s):
            if s[end] not in dic:
                dic[s[end]] = 1
            else:
                dic[s[end]] += 1

            # If the character at p2 appears more than once, move p1 to shrink the window
            if dic[s[end]] > 1:
                while dic[s[end]] > 1:
                    dic[s[start]] -= 1
                    start += 1

            # Update the longest substring length
            max_length = max(max_length, end - start + 1)
            end += 1

        # Return the length of the longest substring found.
        return max_length


s = Solution()
print(s.lengthOfLongestSubstring('pwwkew'))  # Expected output is 3 ("wke")
