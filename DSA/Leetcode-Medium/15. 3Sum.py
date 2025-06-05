# Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.
#
# Notice that the solution set must not contain duplicate triplets.
# Example 1:
#
# Input: nums = [-1,0,1,2,-1,-4]
# Output: [[-1,-1,2],[-1,0,1]]
# Explanation:
# nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
# nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
# nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
# The distinct triplets are [-1,0,1] and [-1,-1,2].
# Notice that the order of the output and the order of the triplets does not matter.
# Example 2:
#
# Input: nums = [0,1,1]
# Output: []
# Explanation: The only possible triplet does not sum up to 0.
# Example 3:
#
# Input: nums = [0,0,0]
# Output: [[0,0,0]]
# Explanation: The only possible triplet sums up to 0.
#from requests.packages import target


class Solution(object):
    def helper(self,tnum, target):
        hash = {}
        for index, val in enumerate(tnum):
            #print(hash,target)
            diff = target-val
            if diff in hash:
                #print(hash,target)
                return [hash[diff],index]
            hash[val] = index

    def threeSum(self, nums):
        """
        :type nums: List[int]
        :rtype: List[List[int]]
        """
        result = []
        i=0
        while i<len(nums):
            target = nums[i]
            temp = nums[:]
            del temp[i]
            l=self.helper(temp,0-target)
            if l:
                if nums[l[0]]+nums[l[1]]+nums[i]==0:
                    result.append([nums[l[0]],nums[l[1]],nums[i]])
            i=i+1
        return result


s = Solution()
print(s.threeSum([-1,0,1,2,-1,-4]))