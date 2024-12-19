def remove_player(f,k,j):
    if len(f)==1:
        return f[0]
    j = (j + k - 1) % len(f)
    f.pop(j)
    return remove_player(f,k,j)

def findTheWinner(n, k):
    if n==1:
        return 1
    f=[]
    for i in range(1,n+1):
        f.append(i)
    j=0
    return remove_player(f,k,j)

print(findTheWinner(4,3))