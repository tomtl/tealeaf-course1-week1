require 'pry'

def create_deck 
  deck = []
  8.times do 
    (2..10).each { |value| deck << value }
    ["J", "Q", "K", "A"].each { |value| deck << value }
  end
  deck # returns deck as array like [1, 2, 3].
end 

def deal_card(deck) 
  deck.delete_at(rand(deck.length))
  # returns one card, eg: '1' or 'K'.
end 

def get_card_value(card)
  card_values = {
    2 => 2, 3 => 3, 4 => 4, 5 => 5,
    6 => 6, 7 => 7, 8 => 8, 9 => 9, 10 => 10, 
    "J" => 10, "Q" => 10, "K" => 10, "A" => 11
  }
  card_values[card] # returns that number value of a card, eg: 5
end 

def get_hand_value(cards)
  value = 0
  cards.each { |card| value += get_card_value(card) }

  if value > 21 && cards.count("A") > 0
    cards_no_aces = cards.select { |card| card != "A" }

    value_no_aces = 0
    if cards_no_aces.count > 0
      cards_no_aces.each { |card| value_no_aces += get_card_value(card) }
    end

    aces_count = cards.count("A")
    value_aces = aces_count * 11

    while aces_count > 0
      aces_count -= 1
      value_aces -= 10
      value = value_no_aces + value_aces
        
      if value <= 21
        return value
        break
      elsif aces_count == 0
        return value
        break
      end
      
    end
  end

  value # returns the numerical value of hand, eg: 17.
end

begin
  puts "=> Welcome to Blackjack! Let's get started."

  deck = create_deck

  # initial deal
  player_cards = []
  dealer_cards = []
  2.times do
    player_cards << deal_card(deck)
    dealer_cards << deal_card(deck)
  end

  puts "=> You have a #{player_cards[0]} and a #{player_cards[1]} which equals #{get_hand_value(player_cards)}."
  puts "=> Dealer's first card is a #{dealer_cards[0]}"

  if get_hand_value(player_cards) == 21
    puts "Blackjack - You win!"
  end

  # user's turn
  begin
    break if get_hand_value(player_cards) == 21
    puts "=> Would you like to hit? (y/n)"
    
    hit = gets.chomp
    until ['y', 'n'].include?(hit.downcase)
      puts "=> That's not a valid entry. Please type 'y' or 'n'."
      hit = gets.chomp
    end
    break if hit == 'n'
  
    player_cards << deal_card(deck)
    puts "=> Now your cards are #{player_cards}, which equals #{get_hand_value(player_cards)}."
  
    if get_hand_value(player_cards) == 21
      puts "=> You win with 21!"
      break
    end
  
    if get_hand_value(player_cards) > 21
      puts "=> Bust. You lost."
      break
    end
  end until hit == "n"
 

  # dealer's turn
  puts "=> Dealer's cards are #{dealer_cards} which equals #{get_hand_value(dealer_cards)}."

  while get_hand_value(dealer_cards) < 17
    break if get_hand_value(player_cards) >= 21
  
    if get_hand_value(dealer_cards) < 17
      puts "=> Dealer hits."
      new_card = deal_card(deck)
      dealer_cards << new_card
      puts "=> Dealer gets a #{new_card}. Now dealer has #{get_hand_value(dealer_cards)}."
    end
  
    if get_hand_value(dealer_cards) > 21
      puts "=> Dealer is bust. You win!"
      break
    end
  
    if get_hand_value(dealer_cards) == 21
      puts "=> Dealer wins with 21!"
      break
    end
    
    if get_hand_value(dealer_cards).between?(17, 21)
      puts "=> Dealer stays on #{get_hand_value(dealer_cards)}."
    end
  end

  # end game
  if get_hand_value(player_cards) < 21 && get_hand_value(dealer_cards) < 21
    puts "=> You have #{get_hand_value(player_cards)} and dealer has #{get_hand_value(dealer_cards)}."
  
    if get_hand_value(player_cards) > get_hand_value(dealer_cards)
      puts "=> You win!" 
    end
  
    if get_hand_value(dealer_cards) >= get_hand_value(player_cards)
      puts "=> Dealer wins" 
    end
  end

  puts "=> Do you want to play again? (y/n)"
  play_again = gets.chomp
end until play_again.downcase == 'n'

puts "=> Thanks for playing!"