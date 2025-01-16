# There is a special typewriter with lowercase English letters 'a' to 'z' arranged in a circle with a pointer. A character can only be typed if the pointer is pointing to that character. The pointer is initially pointing to the character 'a'.
#
# Each second, you may perform one of thefollowing operations:
#
#  Move the pointer one character counterclockwise or clockwise. Type the character the pointer is currently on.
# Given a string word, return the minimumnumber of secondsto type out the characters in word.
# Example 1:
#
# Input: word = "abc"
# Output: 5
# Explanation:
# The characters are printed as follows:
# - Type the character 'a' in 1 second since the pointer is initially on 'a'.
# - Move the pointer clockwise to 'b' in 1 second.
# - Type the character 'b' in 1 second.
# - Move the pointer clockwise to 'c' in 1 second.
# - Type the character 'c' in 1 second.
# Example 2:
#
# Input: word = "bza"
# Output: 7
# Explanation:
# The characters are printed as follows:
# - Move the pointer clockwise to 'b' in 1 second.
# - Type the character 'b' in 1 second.
# - Move the pointer counterclockwise to 'z' in 2 seconds.
# - Type the character 'z' in 1 second.
# - Move the pointer clockwise to 'a' in 1 second.
# - Type the character 'a' in 1 second.
class Solution:
    def minTimeToType(self, word: str) -> int:
        move=0
        pointer='a'
        for i in range(len(word)):
            if word[i]=='a' and move==0:
                pass
            else:
                pointer_rank=ord(pointer)-96
                current_rank = ord(word[i])-96
                clock_distance=abs(current_rank-pointer_rank)
                anti_clock_distance = 26-clock_distance
                move+=min(clock_distance,anti_clock_distance)
            pointer=word[i]

        return move+len(word)

s=Solution()
print(s.minTimeToType('zjpc'))