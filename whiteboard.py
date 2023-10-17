# Given an array nums, write a function to move all 0's to the end of it 
# while maintaining the relative order of the non-zero elements.
# Example:
# Input: [0,1,0,3,12]
# Output: [1,3,12,0,0]
# Example Input: [0,0,11,2,3,4]					
# Example Output: [11,2,3,4,0,0]

# we want a new list or re-arrange the list with all 0 at the end
# maybe using for loop, if [i] == 0, move to [-1:]

def solution(list_):
    zeros = 0
    while 0 in list_:
        list_.remove(0)
        zeros += 1
    list_ = list_ + ([0] * zeros)
    return list_

def solution(nums):
    nums.sort(key=lambda num: 0 if num else 1)
    return nums

