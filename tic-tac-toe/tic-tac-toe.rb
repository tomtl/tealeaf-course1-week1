# draw board
# 1 user choice, redraw
# 2 computer choice
# 3 user choice
# 4 computer choice
# 5 user choice, win check
# 6 computer choice, win check
# 7 user choice, win check
# 8 computer choice, win check
# 9 user choice, win check
# tie, end game

board = [1, 2, 3, 4, 5, 6, 7, 8, 9]

def draw_board(board)
  puts "-------------"
  puts "| #{board[0]} | #{board[1]} | #{board[2]} |"
  puts "-------------"
  puts "| #{board[3]} | #{board[4]} | #{board[5]} |"
  puts "-------------"
  puts "| #{board[6]} | #{board[7]} | #{board[8]} |"
  puts "-------------"
end

def ask_user_for_position(board)
  puts "=> Where do you want to go next?"
  user_choice = gets.chomp
  until board.include?(user_choice.to_i)
    puts "=> That's not a valid entry. Please select a number from 1 to 9."
    user.choice = gets.chomp
  end
end

draw_board(board)

user_choice = ask_user_for_position(board).to_i
board[user_choice -1] = "X"

draw_board(board)

