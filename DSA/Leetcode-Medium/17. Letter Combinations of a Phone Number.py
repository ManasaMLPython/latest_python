# Given a string containing digits from 2-9 inclusive, return all possible letter
# combinations that the number could represent. Return the answer in any order.
#
# A mapping of digits to letters (just like on the telephone buttons) is given below.
# Note that 1 does not map to any letters.
from typing import List


class Solution:
    def letterCombinations(self, digits: str) -> List[str]:
        # Map digits to their respective letters
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

        # Convert the input digits string into a list of individual characters
        digits_list = [c for c in digits]


        final = []

        # Recursive function to compute all combinations
        def helper(d, final1):
            if len(d) == 0:
                # Base case: If no digits remain, return the accumulated combinations
                return final1
            else:
                # Get the letters corresponding to the current digit
                new_digit = d[0]
                new_alphas = letter_combs[new_digit]

                # If no combinations yet, initialize with the current letters
                if not final1:
                    final1 = new_alphas
                else:
                    # Combine existing combinations with the new letters
                    final1 = [x + y for x in final1 for y in new_alphas]

                # Recurse with the remaining digits
                return helper(d[1:], final1)

        return helper(digits_list, final)



s = Solution()
print(s.letterCombinations('23'))

