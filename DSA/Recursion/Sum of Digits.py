# sum_of_digits(1234)  # Output: 10 (1 + 2 + 3 + 4 = 10)

def sum_digit(n):
    if n == 1:
        return 1
    r = n % 10
    n=n//10
    return sum_digit(n)+r

print(sum_digit(12345))