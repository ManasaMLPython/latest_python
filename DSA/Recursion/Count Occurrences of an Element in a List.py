# count_occurrences([1, 2, 3, 2, 4, 2], 2)  # Output: 3

def count_occurrences(arr,n):
    if len(arr)==0:
        return 0
    if arr[0]==n:
        return 1+count_occurrences(arr[1:],n)
    return count_occurrences(arr[1:],n)

print(count_occurrences([2,2,2,2,2,2], 2))
