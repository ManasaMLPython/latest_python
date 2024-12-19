#Given the head of a singly linked list, return true if it is a palindrome or false otherwise.
# Input: head = [1,2,2,1]
# Output: true
# Input: head = [1,2]
# Output: false
from typing import Optional

# Definition for singly-linked list.
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next
class Solution:
    def __init__(self):
        self.head = None
    def addItem(self,li):
        for val in li:
            new_node = ListNode(val)
            if self.head is None:
                self.head=new_node
            else:
                current = self.head
                while current.next:
                    current = current.next
                current.next=new_node
        return self.head
    def printItem(self,head):
        current = head
        while current:
            print(current.val)
            current = current.next

    def isPalindrome(self, head: Optional[ListNode]) -> bool:
        if not head or not head.next:
            return True
        values = []
        while head:
            values.append(head.val)
            head = head.next

        return values == values[::-1]




s = Solution()
head = s.addItem([])
s.printItem(head)
print('*'*40)
print(s.isPalindrome(head))


# def isPalindrome(self, head: Optional[ListNode]) -> bool:
#     head = head
#     tail = head
#     prev = None
#     if head.next is None:
#         return True
#     while head:
#         while tail.next:
#             prev = tail
#             tail = tail.next
#         if tail.val != head.val:
#             return False
#         else:
#             tail = prev
#             tail.next = None
#             tail = head
#             head = head.next
#     return True

# def isPalindrome(self, head):
#     if head.next is None:
#         return True
#     else:
#         mid = head
#         temp = head
#         while temp and temp.next:
#             mid = mid.next
#             temp = temp.next.next
#         prev = None
#         curr = mid
#         while curr:
#             nxt = curr.next
#             curr.next = prev
#             prev = curr
#             curr = nxt
#         while prev:
#             if head.val != prev.val:
#                 return False
#             head = head.next
#             prev = prev.next
#         return True







