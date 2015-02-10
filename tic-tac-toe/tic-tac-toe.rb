
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
  valid_positions = get_available_positions(board)
  until valid_positions.include?(board.key(user_choice.to_i))
    puts "=> Thats not a valid entry. Please enter a number for an available spot."
    user_choice = gets.chomp
  end
  return user_choice
end # returns a board[value] like '1'

def get_computer_pick(board)
  board[get_available_positions(board).sample]
end # returns a board[value] like '1'

def get_computer_pick_with_ai(board)
  winning_combinations = [
    [11, 12, 13], [21, 22, 23], [31, 32, 33], # verticals
    [11, 21, 31], [12, 22, 32], [13, 23, 33], # horizontals
    [11, 22, 33], [13, 22, 31]                # diagonals
  ]
  user_positions = get_user_positions(board)
  computer_positions = get_computer_positions(board)
  
  needed_for_win = []
  winning_combinations.each do |combo| 
    needed_for_win << (combo - computer_positions)
  end
  
  possible_win_combos = []
  needed_for_win.each do |combo| 
    possible_win_combos << combo if (combo & user_positions).empty?
  end
  
  combo_lengths = []
  possible_win_combos.each { |combo| combo_lengths << combo.length }
  
  best_combos = []
  possible_win_combos.each do |combo| 
    best_combos << combo if combo.length == combo_lengths.min
  end
  
  board[best_combos.sample.sample]
end # Returns a board[value] like '1'

def get_available_positions(board)
  available_positions = []
  board.each do |position, value|
    available_positions << position unless ["X", "o"].include?(value)
  end
  available_positions
end # Returns a board[key] like '11'

def add_turn_to_board(player, position, board)
  x_or_o = {"user" => "X", "computer" => "o"}
  board[board.key(position)] = x_or_o[player]
  board
end

def get_user_positions(board)
  user_positions = []
  board.each { |position, value| user_positions << position if value == "X" }
  user_positions
end # returns an array of board[keys] like '[11, 12, 13]'

def get_computer_positions(board)
  computer_positions = []
  board.each do |position, value| 
    computer_positions << position if value == "o"
  end
  computer_positions
end # returns an array of board[keys] like '[11, 12, 13]'
  
def did_player_win?(player, board)
  winning_combinations = [
    [11, 12, 13], [21, 22, 23], [31, 32, 33], # verticals
    [11, 21, 31], [12, 22, 32], [13, 23, 33], # horizontals
    [11, 22, 33], [13, 22, 31]                # diagonals
  ]
  player_positions = get_user_positions(board) if player == "user"
  player_positions = get_computer_positions(board) if player == "computer"
  winning_combinations.each do |combination|
    if (combination & player_positions) == combination
      return true
    end
  end
  nil
end # returns true or nil


begin
  puts "=> Welcome to tic-tac-toe. You are 'X' and computer is 'o'."
  board = {
  13 => 1, 23 => 2, 33 => 3, 
  12 => 4, 22 => 5, 32 => 6, 
  11 => 7, 21 => 8, 31 => 9
  }
  turn_count = 0
  win = nil

  begin
    # user's turn
    draw_board(board)
    user_choice = ask_user_for_position(board)
    board = add_turn_to_board("user", user_choice.to_i, board)
    win = did_player_win?("user", board)

    if win
      puts "=> You won!"
      break
    end

    turn_count += 1

    if turn_count >= 9
      puts "=> It's a tie."
      break
    end

    # computer's turn
    computer_choice = get_computer_pick_with_ai(board)
    puts "=> Computer chose #{computer_choice}"
    board = add_turn_to_board("computer", computer_choice, board)
    win = did_player_win?("computer", board)
    if win
      draw_board(board)
      puts "=> You lost. Better luck next time."
      break
    end
    turn_count += 1

  end until turn_count >= 9
  
  # Check if the user wants to play again
  puts "=> Would you like to play again? (Type 'yes' or 'no')."
  play_again = gets.chomp
  until ['yes', 'no'].include?(play_again.downcase)
    puts "=> Thats not a valid entry. Please type 'yes' or 'no'."
    play_again = gets.chomp
  end
  
end until play_again.downcase == 'no'
puts "=> Thanks for playing!"
