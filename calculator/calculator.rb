def say(message)
  puts "=> #{message}"
end

begin
  say "What is your first number?"
  number1 = gets.chomp

  say "What is your second number?"
  number2 = gets.chomp

  say "Which calculation would you like to perform?"
  puts "1) Add, 2) Subtract, 3) Multiply, 4) Divide"
  calc_type  = gets.chomp

  case calc_type
    when "1" then answer = number1.to_i + number2.to_i
    when "2" then answer = number1.to_i - number2.to_i
    when "3" then answer = number1.to_i * number2.to_i
    when "4" then answer = number1.to_f / number2.to_f
  end

  say "That equals #{answer}!"
  say "Would you like to do another calculation? (Type 'yes' or 'no')"
  again = gets.chomp
end while again == "yes"


