# reverse_string("hello")  # Output: "olleh"

def reverse_string(s):
    if len(s)<1:
        return ""
    elif len(s)==1:
        return s
    return s[-1]+reverse_string(s[:-1])

print(reverse_string('hello'))