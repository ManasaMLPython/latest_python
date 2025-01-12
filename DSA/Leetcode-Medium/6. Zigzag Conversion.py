# The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this: (you may want to display this pattern in a fixed font for better legibility)
# P   A   H   N
# A P L S I I G
# Y   I   R
# And then read line by line: "PAHNAPLSIIGYIR"
#
# Write the code that will take a string and make this conversion given a number of rows:
#
# string convert(string s, int numRows);
# Example 1:
#
# Input: s = "PAYPALISHIRING", numRows = 3
# Output: "PAHNAPLSIIGYIR"
# Example 2:
#
# Input: s = "PAYPALISHIRING", numRows = 4
# Output: "PINALSIGYAHRPI"
# Explanation:
# P     I    N
# A   L S  I G
# Y A   H R
# P     I
# Example 3:
#
# Input: s = "A", numRows = 1
# Output: "A"

class Solution:
    def convert(self, s: str, numRows: int) -> str:
        #If numRows is 1, there's no zigzag pattern
        if numRows == 1:
            return s

        # array that holds strings of each row
        result = [''] * numRows

        row_num = 0
        # the zigzag pattern looks like sign wave. when going down the row num increases
        # if going up row num decreases
        down = True

        for c in s:
            result[row_num] += c


            if down:
                row_num += 1

            else:
                row_num -= 1

            # if reached last row inverse the direction
            if row_num == numRows - 1:
                down = False
            if row_num == 0:
                down = True

        # Join all rows together for final string
        return ''.join(result)


s= Solution()
print(s.convert("AB",1))
