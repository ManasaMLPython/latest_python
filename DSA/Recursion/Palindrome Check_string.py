# is_palindrome("racecar")  # Output: True
# is_palindrome("hello")    # Output: False

def is_palindrome(s):
    if len(s)<1:
        return True
    if s[0]!=s[-1]:
        return False
    print(s)
    return is_palindrome(s[1:-1])

print(is_palindrome('12321'))