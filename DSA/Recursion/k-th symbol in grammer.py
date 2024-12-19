class Solution:
    def kthGrammar(self, n: int, k: int) -> int:
        if n == 1:
            return 0  # Base case: Row 1 is always [0]

        n_sym = 2 ** (n - 1)  # Total symbols in the nth row
        mid = n_sym // 2  # The middle index that separates the two halves

        if k > mid:  # If k is in the second half of the row
            k = k - mid  # Adjust k to represent its position in the first half
            return 1 - self.kthGrammar(n - 1, k)  # Invert the result for the second half

        return self.kthGrammar(n - 1, k)  # Recurse into the first half


s= Solution()
print(s.kthGrammar(3,4))


