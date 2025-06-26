import re


def str_palin(s):
    s_new = re.sub(r'[^a-zA-Z0-9]','',s)
    return s_new==s_new[::-1]

print(str_palin('ab ab'))