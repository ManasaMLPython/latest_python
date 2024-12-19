# Given a string containing digits from 2-9 inclusive, return all possible letter
# combinations that the number could represent. Return the answer in any order.
#
# A mapping of digits to letters (just like on the telephone buttons) is given below.
# Note that 1 does not map to any letters.
from typing import List


class Solution:
    def letterCombinations(self, digits: str) -> List[str]:
        letter_combs = {
            '2': ['a', 'b', 'c'],
            '3': ['d', 'e', 'f'],
            '4': ['g', 'h', 'i'],
            '5': ['j', 'k', 'l'],
            '6': ['m', 'n', 'o'],
            '7': ['p', 'q', 'r', 's'],
            '8': ['t', 'u', 'v'],
            '9': ['w', 'x', 'y', 'z']
        }
        digits_list = [c for c in digits]
        # print(digits)
        final = []
        if len(digits_list) == 1:
            final = [c for c in letter_combs[digits_list[0]]]
            return final

        def helper(d, final1):
            if len(d) == 0:
                return final1
            else:
                new_digit = d[0]
                new_alphas = letter_combs[new_digit]
                if not final1:
                    final1 = new_alphas
                else:
                    final1 = [x + y for x in final1 for y in new_alphas]
                return helper(d[1:], final1)

        return helper(digits_list, final)

s = Solution()
print(s.letterCombinations('23'))


