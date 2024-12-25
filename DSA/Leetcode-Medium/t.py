from typing import List


class Solution:
    def removeElement(self, nums: List[int], val: int) -> int:
        # Initialize two pointers: p1 to track valid elements and p2 to iterate through the array
        p1 = 0
        p2 = 0
        while p2 < len(nums):
            if nums[p2] != val:
                # Swap the element at p1 and p2 to move valid elements to the front
                t = nums[p1]
                nums[p1] = nums[p2]
                nums[p2] = t

                # Increment p1 to indicate the next position for a valid element
                p1 += 1

            p2 += 1

        return p1


s = Solution()
print(s.removeElement([3,2,2,3],3))
