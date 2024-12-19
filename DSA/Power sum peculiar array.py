def helper(array, power, total):
    temp = 0
    for i in array:
        if not isinstance(i, list):
            temp = temp + i
            #print(temp)
        else:
            print(power)
            temp += helper(i, power + 1, total)
    total += (temp ** power)

    return total

def power_sum(array,power=1):

    return helper(array,power,0)


print(power_sum([1,2,[3,4],[[2]]]))

#2,[5,10, [2, 4], [[5], [2,2]], [2,3,[2,3,[2,3],5,5], [4,6],3,7],3,3]