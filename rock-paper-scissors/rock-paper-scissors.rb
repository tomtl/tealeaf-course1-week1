def say(message)
  puts "=> #{message}"
end

begin

  # User pick
  say "Your turn. Type 'r' for rock, 'p' for paper, or 's' for scissors."
  user_pick = gets.chomp
  until ['r', 'p', 's'].include?(user_pick.downcase)
    say "Thats not a valid entry. Please type 'r' for rock, 'p' for paper, or 's' for scissors."
    user_pick = gets.chomp
  end

  # Computer pick
  computer_pick = ['r', 'p', 's'].sample
  say "Computer chose '#{computer_pick}'"

  # Compare picks and determine winner
  picks = [user_pick.downcase, computer_pick]
  winning_combinations = [['r', 's'], ['s', 'p'], ['p', 'r']]
  if winning_combinations.include?(picks)
    say "You win!"
  elsif user_pick.downcase == computer_pick
    say "It's a tie!"
  else
    say "You lose. Better luck next time!"
  end

  # Check if the user wants to play again
  say "Would you like to play again? (Type 'yes' or 'no')."
  play_again = gets.chomp
  until ['yes', 'no'].include?(play_again.downcase)
    say "Thats not a valid entry. Please type 'yes' or 'no'."
    play_again = gets.chomp
  end
  
end while play_again.downcase == 'yes'