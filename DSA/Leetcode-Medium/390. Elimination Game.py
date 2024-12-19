# You have a list arr of all integers in the range [1, n] sorted in a strictly
# increasing order. Apply the following algorithm on arr:
# Starting from left to right, remove the first number and every other number afterward until
# you reach the end of the list.
# Repeat the previous step again, but this time from right to left, remove the rightmost number
# and every other number from the remaining numbers.
# Keep repeating the steps again, alternating left to right and right to left, until a
# single number remains.Given the integer n, return the last number that remains in arr.

class Solution:

    def lastRemaining(self, n: int) -> int:

        return 1





s= Solution()
print(s.lastRemaining(100000))


# def lastRemaining(self, n: int) -> int:
#     arr = [i for i in range(1, n + 1)]
#     print(len(arr))
#     if len(arr) == 1:
#         return arr[0]
#     else:
#         order = True
#         while len(arr) > 1:
#             if order:
#                 i = 0
#                 while i < len(arr):
#                     arr.pop(i)
#                     i = i + 1
#
#             else:
#                 i = -1
#                 while i >= len(arr) * -1:
#                     arr.pop(i)
#                     i = i - 1
#             print(len(arr))
#             order = not order
#     return arr
#sol2
# def lastRemaining(self, n: int) -> int:
#     arr = list(range(1, n + 1))  # Initialize the list [1, 2, ..., n]
#     left_to_right = True  # We start with left to right
#
#     while len(arr) > 1:
#         if left_to_right:
#             # Eliminate every second element from left to right
#             arr = arr[1::2]  # Take every second element (i.e., elements at even indices)
#         else:
#             # Eliminate every second element from right to left
#             arr = sorted(arr[-2::-2])  # Take every second element in reverse (starting from the second-to-last)
#
#         # Switch direction
#         left_to_right = not left_to_right
#     return arr[0]

