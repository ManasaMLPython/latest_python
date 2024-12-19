def remove_player(f,k):
    if f==1:
        return 0
    return (remove_player(f-1,k)+k)%f

def findTheWinner(n, k):
    return remove_player(n,k)+1

print(findTheWinner(3,2))