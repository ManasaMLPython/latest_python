#  You are given an integer array height of length n. There are n vertical lines drawn such that the two
# endpoints of the ith line are (i, 0) and (i, height[i]).
#
# Find two lines that together with the x-axis form a container, such that the container contains the most water.
# Return the maximum amount of water a container can store.
#
# Input: height = [1,8,6,2,5,4,8,3,7]
# Output: 49
# Explanation: The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.
# Example 2:
#
# Input: height = [1,1]
# Output: 1

class Solution(object):
    def maxArea(self, height):
        # Initialize two pointers and a list to store possible areas
        result = []
        first = 0
        last = len(height) - 1

        while first < last:
            # Calculate the area formed between the two lines
            temp = min(height[first], height[last]) * (last - first)
            result.append(temp)

            # Move the pointer at the shorter line inward
            if height[first] > height[last]:
                last -= 1
            else:
                first += 1

        return max(result)

s = Solution()
print(s.maxArea([8,7,2,1]))
