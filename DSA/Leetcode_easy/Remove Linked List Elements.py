#Given the head of a linked list and an integer val, remove all the nodes of the linked list
# that has Node.val == val, and return the new head.
# Input: head = [1,2,6,3,4,5,6], val = 6
# Output: [1,2,3,4,5]
# Example 2:
#
# Input: head = [], val = 1
# Output: []
# Example 3:
#
# Input: head = [7,7,7,7], val = 7
# Output: []
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

    def removeElements(self, head: Optional[ListNode], val: int) -> Optional[ListNode]:
        remove = head
        current = remove
        prev = None
        while current:
            if current.val==val:
                nxt = current.next
                current.next = None
                if prev is not None:
                    current = prev
                    current.next = nxt
                    current = current.next
                else:
                    current = nxt
                    remove = current
            else:
                prev = current
                current = current.next
        return remove

s = Solution()
head = s.addItem([1,2,1,3])
s.printItem(head)
print('*'*40)
removed_list_head = s.removeElements(head,1)
s.printItem(removed_list_head)








