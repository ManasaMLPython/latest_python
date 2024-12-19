from collections import Counter

a = 'cabwefgewcwaefgcf'
b='cae'
b_count = Counter(b)
win = 2
l =0
r=2

subs=[]
def help(win):
    while win<=len(a):
        #print(win)
        l = 0
        r = win
        while r<=len(a):
            boo = True
            sub = a[l:r]
            #print(sub)
            sub_c = Counter(sub)
            for ch,co in b_count.items():
                if sub_c[ch]<b_count[ch]:
                    boo = False
                    break
            if boo:
                subs.append(sub)
            l +=1
            r +=1
            if len(subs)==1:
                return subs[0]
        if len(subs)==1:
            return subs[0]
        win +=1



print(help(win))
