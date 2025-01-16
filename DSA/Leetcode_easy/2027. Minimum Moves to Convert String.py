# You are given a string s consisting of n characters which are either 'X' or 'O'.
#
# A move is defined as selecting three consecutive characters of s and converting them to 'O'. Note that if a move is applied to the character 'O', it will stay the same.
#
# Return the minimum number of moves required so that all the characters of s are converted to 'O'.
# Example 2:
#
# Input: s = "XXOX"
# Output: 2
# Explanation: XXOX -> OOOX -> OOOO
# We select the first 3 characters in the first move, and convert them to 'O'.
# Then we select the last 3 characters and convert them so that the final string contains all 'O's.

class Solution:
    def minimumMoves(self, s: str) -> int:

        if len(s)==3:
            if s=='000':
                return 0
            else:
                return 1
        start=0
        m=0
        while start<len(s):
            sub=s[start:start+3]
            print(sub)
            x=0
            z=False
            while x<3:
                if sub[x]=='x':
                    z=True
                    break
                x+=1
            if z:
                m+=1
            left_ch=len(s)-3*m
            if left_ch<0:
                break
            start+=left_ch
        return m



s=Solution()
print(s.minimumMoves(s = "xx0x"))