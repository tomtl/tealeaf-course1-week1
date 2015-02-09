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

require 'pry'

board = {
  13 => 1, 23 => 2, 33 => 3, 
  12 => 4, 22 => 5, 32 => 6, 
  11 => 7, 21 => 8, 31 => 9
}

def draw_board(board)
  puts "-------------"
  puts "| #{board[13]} | #{board[23]} | #{board[33]} |"
  puts "-------------"
  puts "| #{board[12]} | #{board[22]} | #{board[32]} |"
  puts "-------------"
  puts "| #{board[11]} | #{board[21]} | #{board[31]} |"
  puts "-------------"
end

def ask_user_for_position(board)
  puts "=> Where do you want to go next?"
  user_choice = gets.chomp
  #until board.include?(user_choice.to_i)
  #  puts "=> That's not a valid entry. Please select a number from 1 to 9."
  #  user.choice = gets.chomp
  #end
end

def add_turn_to_board(player, position, board)
  x_or_o = {"player" => "X", "computer" => "O"}
  board[position] = x_or_o[player]
  board
end

def get_user_positions(board)
  user_positions = []
  board.each { |position, value| user_positions << position if value == "X" }
  user_positions
end

def get_computer_positions(board)
  computer_positions = []
  board.each do |position, value| 
    computer_positions << position if value == "O"
  end
  computer_positions
end
  
def did_player_win?(player_positions)
  winning_combinations = [[11, 12, 13], [21, 22, 23], [31, 32, 33]]
  winning_combinations.each do |combination|
    if (combination & player_positions) == combination
      return True
    end
  end
end

draw_board(board)
user_choice = ask_user_for_position(board)
board = add_turn_to_board("user", user_choice.to_i, board)


