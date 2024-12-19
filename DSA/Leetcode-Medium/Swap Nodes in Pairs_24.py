# Given a linked list, swap every two adjacent nodes and return its head.
# You must solve the problem without modifying the values in the list's nodes
# (i.e., only nodes themselves may be changed.)
# Example 1:
# Input: head = [1,2,3,4]
# Output: [2,1,4,3]
# Example 2:
# Input: head = []
# Output: []
# Example 3:
# Input: head = [1]
# Output: [1]
# Example 4:
# Input: head = [1,2,3]
# Output: [2,1,3]
from typing import Optional



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

    def swapPairs(self, head: Optional[ListNode]) -> Optional[ListNode]:
        if head is None or head.next is None:
            return head
        else:
            dummy = ListNode(0)
            dummy.next = head
            prev = dummy
            current = head
            while current and current.next:
                #nxt pair
                nxt_p = current.next.next
                second = current.next

                #swap
                second.next = current
                current.next = nxt_p
                prev.next = second

                # change to next pair
                prev = current
                current = nxt_p
        return dummy.next


s = Solution()
head = s.addItem([1,2,3,4,5,6,7])
s.printItem(head)
print('*'*40)
s.printItem(s.swapPairs(head))