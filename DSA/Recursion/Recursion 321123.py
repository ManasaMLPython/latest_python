def recur(n):

    if n<1:
        return
    else:
        print(n,end='')
        recur(n-1)
    print(n,end='')

recur(9)