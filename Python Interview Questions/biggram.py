# 21. Write a function that can take a string and return a list of bigrams.
# Example:

sentence = "need someone to talk to? I am here  ...   My      best friend."
biggram = []
sentence = sentence.split(' ')
print(sentence)
for i in range(0,len(sentence)-1):
    biggram.append((sentence[i].strip(),sentence[i+1].strip()))
print(biggram)
