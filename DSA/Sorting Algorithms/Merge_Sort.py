def merge_sort(arr):
    if len(arr)>1:
        left_arr = arr[:len(arr)//2]
        right_arr = arr[len(arr)//2:]
        #print(left_arr)
        merge_sort(left_arr)
        merge_sort(right_arr)

        l=0
        r=0
        m=0
        #print(arr)
        while l<len(left_arr) and r<len(right_arr):
            if left_arr[l]<right_arr[r]:
                arr[m]=left_arr[l]
                l += 1
                m +=1
            else:
                arr[m]=right_arr[r]
                r += 1
                m +=1
        while l<len(left_arr):
            arr[m] = left_arr[l]
            l += 1
            m += 1
        while r<len(right_arr):
            arr[m] = right_arr[r]
            r += 1
            m += 1
        print(arr)
arr = [9,3,4,1,2,5,2,7,6]
#print(arr)
merge_sort(arr)
#print(arr)