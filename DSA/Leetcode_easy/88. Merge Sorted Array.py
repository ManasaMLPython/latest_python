# You are given two integer arrays nums1 and nums2, sorted in non-decreasing order, and two integers m and n, representing the number of elements in nums1 and nums2 respectively.
#
# Merge nums1 and nums2 into a single array sorted in non-decreasing order.
#
# The final sorted array should not be returned by the function, but instead be stored inside the array nums1. To accommodate this, nums1 has a length of m + n, where the first m elements denote the elements that should be merged, and the last n elements are set to 0 and should be ignored. nums2 has a length of n.
#
# Example 1:
#
# Input: nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
# Output: [1,2,2,3,5,6]
# Explanation: The arrays we are merging are [1,2,3] and [2,5,6].
# The result of the merge is [1,2,2,3,5,6] with the underlined elements coming from nums1.
# Example 2:
#
# Input: nums1 = [1], m = 1, nums2 = [], n = 0
# Output: [1]
# Explanation: The arrays we are merging are [1] and [].
# The result of the merge is [1].
# Example 3:
#
# Input: nums1 = [0], m = 0, nums2 = [1], n = 1
# Output: [1]
# Explanation: The arrays we are merging are [] and [1].
# The result of the merge is [1].
# Note that because m = 0, there are no elements in nums1. The 0 is only there to ensure the merge result can fit in nums1.
from typing import List


class Solution:
    def merge(self, nums1: List[int], m: int, nums2: List[int], n: int) -> None:
        # Pointer to the last index of nums1
        tail_num1 = m + n - 1

        # Pointers to the last valid elements in nums1 and nums2
        num1_last_valid, num2_last = m - 1, n - 1

        # Merge nums1 and nums2 from the end towards the start
        while num2_last >= 0 and num1_last_valid >= 0:
            if nums1[num1_last_valid] < nums2[num2_last]:
                nums1[tail_num1] = nums2[num2_last]
                num2_last -= 1
            elif nums1[num1_last_valid] == nums2[num2_last]:
                nums1[tail_num1] = nums2[num2_last]
                num2_last -= 1
            else:
                nums1[tail_num1] = nums1[num1_last_valid]
                num1_last_valid -= 1
            tail_num1 -= 1

        # If there are remaining elements in nums2, copy them over to nums1
        while num2_last >= 0:
            nums1[tail_num1] = nums2[num2_last]
            tail_num1 -= 1
            num2_last -= 1



s=Solution()
s.merge( nums1 = [4,0,0,0,0,0], m = 1, nums2 = [1,2,3,5,6], n = 5)
