# Given a 0-indexed string word and a character ch, reverse the segment of word that starts at index 0 and ends at the index of the first occurrence of ch (inclusive). If the character ch does not exist in word, do nothing.
#
# For example, if word = "abcdefd" and ch = "d", then you should reverse the segment that starts at 0 and ends at 3 (inclusive). The resulting string will be "dcbaefd".
# Return the resulting string.
# Example 1:
#
# Input: word = "abcdefd", ch = "d"
# Output: "dcbaefd"
# Explanation: The first occurrence of "d" is at index 3.
# Reverse the part of word from 0 to 3 (inclusive), the resulting string is "dcbaefd".
# Example 2:
#
# Input: word = "xyxzxe", ch = "z"
# Output: "zxyxxe"
# Explanation: The first and only occurrence of "z" is at index 3.
# Reverse the part of word from 0 to 3 (inclusive), the resulting string is "zxyxxe".
# Example 3:
#
# Input: word = "abcd", ch = "z"
# Output: "abcd"
# Explanation: "z" does not exist in word.
# You should not do any reverse operation, the resulting string is "abcd".

class Solution:
    def reversePrefix(self, word: str, ch: str) -> str:
        index = -1

        for i in range(len(word)):
            if word[i] == ch:
                index = i  # Update `index` when `ch` is found.
                break  # Exit the loop after finding the first occurrence of `ch`.

        # Check if `ch` was not found in the word.
        if index == -1:
            return word  
        else:
            # Reverse the prefix up to `index` and concatenate it with the rest of the word.
            return word[:index + 1][::-1] + word[index + 1:]


s= Solution()
print(s.reversePrefix(word = "abcd", ch = "c"))