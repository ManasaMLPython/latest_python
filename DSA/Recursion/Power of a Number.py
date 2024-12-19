# power(2, 3)  # Output: 8 (2^3 = 8)

def pow(b,e):
    if e==1:
        return b
    return pow(b,e-1)*b

print(pow(2,4))