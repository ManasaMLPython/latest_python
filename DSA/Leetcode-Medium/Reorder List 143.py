# You are given the head of a singly linked-list. The list can be represented as:
# L0 → L1 → … → Ln - 1 → Ln
# Reorder the list to be on the following form:
# L0 → Ln → L1 → Ln - 1 → L2 → Ln - 2 → …
# You may not modify the values in the list's nodes. Only nodes themselves may be changed.
# Input: head = [1,2,3,4]
# Output: [1,4,2,3]
# Input: head = [1,2,3,4,5]
# Output: [1,5,2,4,3]


from typing import Optional

from debugpy.common.timestamp import current


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

    def reorderList(self, head: Optional[ListNode]):
        if head is None or head.next is None or head.next.next is None:
            return head
        else:
            mid,temp = head,head
            while temp and temp.next:
                mid = mid.next
                temp = temp.next.next
            # reverse the second part
            prev = None
            current = mid
            while current:
                temp = current.next
                current.next = prev
                prev = current
                current = temp
            mid = prev
            current = head
            while mid.next:
                # store next pointers in both lists
                nxt_mid = mid.next
                nxt_curr = current.next

                # swap
                current.next = mid
                mid.next = nxt_curr

                # move to next pointers
                current = nxt_curr
                mid = nxt_mid
            return head

s = Solution()
head = s.addItem([1,2,3,4,5])
s.printItem(head)
print('*'*40)
s.printItem(s.reorderList(head))