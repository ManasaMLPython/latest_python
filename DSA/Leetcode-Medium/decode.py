# Given an encoded string, return its decoded string.
# The encoding rule is: k[encoded_string], where the encoded_string inside the square brackets is
# being repeated exactly k times. Note that k is guaranteed to be a positive integer.
# You may assume that the input string is always valid; there are no extra white spaces,
# square brackets are well-formed, etc. Furthermore, you may assume that the original data
# does not contain any digits and that digits are only for those repeat numbers, k.
# For example, there will not be input like 3a or 2[4].
# The test cases are generated so that the length of the output will never exceed 105.
# Example 1:
# Input: s = "3[a]2[bc]"
# Output: "aaabcbc"
# Example 2:
# Input: s = "3[a2[c]]"
# Output: "accaccacc"
# Example 3:
# Input: s = "2[abc]3[cd]ef"
# Output: "abcabccdcdcdef
class Solution:
    def decodeString(self, s: str) -> str:
        final = []  # Stack to store characters and substrings
        for c in s:
            if c != ']':  # If it's not a closing bracket, add to stack
                final.append(c)
            else:
                curr = ''
                # Build the current string by popping until '['
                while final[-1] != '[':
                    curr = final.pop() + curr
                final.pop()  # Remove the '[' from stack

                num = ''
                # Build the number (multiplier) by popping digits
                while final and final[-1].isdigit():
                    num = final.pop() + num

                # Repeat the substring and push back to stack
                rep_str = int(num) * curr
                final.append(rep_str)

        return ''.join(final)  # Join the stack into the final decoded string


s = Solution()
print(s.decodeString('2[abc]3[cd]ef'))