# Given the head of a singly linked list, reverse the list, and return the reversed list.
# Input: head = [1,2,3,4,5]
# Output: [5,4,3,2,1]
#Input: head = [1,2]
#Output: [2,1]
#Input: head = []
#Output: []
from os.path import curdir
from typing import Optional


#Definition for singly-linked list.
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next
class Solution:
    def __init__(self):
        self.head = None
    def addItem(self,l):
        for val in l:
            new_node = ListNode(val)
            if self.head is None:
                self.head=new_node
            else:
                cur = self.head
                while cur.next:
                    cur = cur.next
                cur.next = new_node
        return self.head
    def printItem(self,lnh):
        self.head = lnh
        cur = self.head
        li = []
        while cur:
            li.append(cur.val)
            cur = cur.next
        print(li)
    def reverseList(self, head: Optional[ListNode]) -> Optional[ListNode]:
        reverse_node = None
        current_node = head
        while current_node:
            next_node = current_node.next
            current_node.next = reverse_node
            reverse_node = current_node
            current_node = next_node
        return reverse_node

s = Solution()
original = s.addItem([])
s.printItem(original)
reversed_list = s.reverseList(original)
s.printItem(reversed_list)



