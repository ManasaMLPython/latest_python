# sample print statement below
# print("move disk " + 1 + " from rod " + 1 + " to rod " + 2)
# in the above statement consider we are moving disk 1 from rod 1 to rod 2
# remember to return number of moves as well

def mover(n, start, Desti, temp,count):
    if n==1:
        print("move disk " + str(n) + " from rod " + start + " to rod " + Desti)
        count += 1
        return count
    else:

        #count += 1
        count = mover(n-1, start, temp,Desti,count)
        print("move disk " + str(n) + " from rod " + start + " too rod " + Desti)
        count+=1
        count = mover(n-1,temp,Desti, start,count)
        # print("move disk " + str(n) + " from rod " + start + " to rod " + temp)
        return count

def toh(n, start, Desti, temp):
    count = 0
    if n<1:
        print('Nothing to move')
    else:
        count = mover(n,start,Desti,temp,count)

    return count


c = toh(3, 'Start', 'Desti', 'temp')
print('Total number of moves = ', c)