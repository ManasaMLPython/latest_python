#You are given two non-empty linked lists representing two non-negative integers.
# The digits are stored in reverse order, and each of their nodes contains a single digit.
# Add the two numbers and return the sum as a linked list.
# You may assume the two numbers do not contain any leading zero, except the number 0 itself.
from typing import Optional


#Input: l1 = [2,4,3], l2 = [5,6,4]
# Output: [7,0,8]
# Explanation: 342 + 465 = 807.

# Example 2:
# Input: l1 = [0], l2 = [0]
# Output: [0]

# Example 3:
# Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
# Output: [8,9,9,9,0,0,0,1]

# Definition for singly-linked list.
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next
class Solution:
    def __init__(self):
        self.head = None
        #self.insertItem(l)
    def insertItem(self,l):
        for val in l:
            new_node = ListNode(val)
            new_node.next = self.head
            self.head=new_node
        return self.head
    def printItem(self):
        cur = self.head
        while cur:
            print(cur.val)
            cur = cur.next
    def assignList(self,l1,l2):
        #print(l1.val)
        if l1:
            print('none l1')
            return l1
        elif l2:
            print('none l2')
            return l2
        else:
            print('none')
            return None

    def addTwoNumbers(self, l1: Optional[ListNode], l2: Optional[ListNode]) :
        carry = 0
        total = []
        while l1 and l2:
            val1 = l1.val if l1 else 0
            val2 = l2.val if l2 else 0
            t = val1 + val2 +carry
            carry = t//10
            t = t%10
            total.append(t)
            l1 = l1.next
            l2 = l2.next
        l = ListNode()
        l = l1 if l1 else l2 if l2 else None
        while l:
            t = l.val+carry
            carry = t//10
            total.append(t%10)
            l = l.next
        if carry!=0:
            total.append(carry)
        return total



s1= Solution()
s2 = Solution()
s3 = Solution()

l1 = s1.insertItem([2,4,3])
l2 = s2.insertItem([5,6,4])
s1.printItem()
print('&&&&&&')
s2.printItem()
#print(l1,l2)
print(s3.addTwoNumbers(l1,l2))

