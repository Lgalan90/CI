#!/usr/bin/python
# -*- coding: utf-8 -*-
import random
import os
board = [' ',' ',' ',
         ' ',' ',' ',
         ' ',' ',' ']

# def gameRules():
#    print("""Enter the number corresponding to the location on the board:
#          0|1|2
#          -----
#          3|4|5
#          -----
#          6|7|8 """)
def gameBoard():
    print (board[0], '|', board[1], '|', board[2])
    print ('----------')
    print (board[3], '|', board[4], '|', board[5])
    print ('----------')
    print (board[6], '|', board[7], '|', board[8])
while True:
    gameBoard()
    choice = int(input('Enter move: '))
    
    # enter player option to empty space
    if board[choice - 1] == ' ' and board[choice - 1] != 'x' and board[choice - 1] != 'o':
        board[choice - 1] = 'x'
        # enter computer random option to empty space
        computerChoice = random.randrange(1, 10)
        if board[computerChoice - 1] == ' ' and board[computerChoice - 1] != 'x' and board[computerChoice - 1] != 'o':
            board[computerChoice - 1] = 'o'  
            continue
    else:
        gameBoard()
        print('Try a different space...')
        
        if (board[0] == "x" and board[1] == "x" and board[2] == "x") or \
            (board[3] == "x" and board[4] == "x" and board[5] == "x") or \
            (board[6] == "x" and board[7] == "x" and board[8] == "x") or \
            (board[0] == "x" and board[3] == "x" and board[6] == "x") or \
            (board[1] == "x" and board[4] == "x" and board[7] == "x") or \
            (board[2] == "x" and board[5] == "x" and board[8] == "x") or \
            (board[0] == "x" and board[4] == "x" and board[8] == "x") or \
            (board[2] == "x" and board[4] == "x" and board[6] == "x"):
            print("X Wins!")
        if (board[0] == "o" and board[1] == "o" and board[2] == "o") or \
            (board[3] == "o" and board[4] == "o" and board[5] == "o") or \
            (board[6] == "o" and board[7] == "o" and board[8] == "o") or \
            (board[0] == "o" and board[3] == "o" and board[6] == "o") or \
            (board[1] == "o" and board[4] == "o" and board[7] == "o") or \
            (board[2] == "o" and board[5] == "o" and board[8] == "o") or \
            (board[0] == "o" and board[4] == "o" and board[8] == "o") or \
            (board[2] == "o" and board[4] == "o" and board[6] == "o"):
            print("O Wins!")
       