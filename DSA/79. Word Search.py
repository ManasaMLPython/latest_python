def search(board,word):
    result = True
    word_found = ''
    def helper(word_index,board_index):
        if result==False:
            return
        if word_found==word:
            return

        return result
    word_index_=0
    board_index_=0
    helper(word_index_,board_index_)
    return result


board =[["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
word = "ABCB"
print(search(board,word))