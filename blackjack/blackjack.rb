
def create_deck
  deck = []
  8.times do 
    (2..10).each { |value| deck << value }
    ["J", "Q", "K", "A"].each { |value| deck << value }
  end
  deck
end # returns deck as array like [1, 2, 3].

def deal_card(deck)
  deck.delete_at(rand(deck.length))
end # returns one card, eg: '1' or 'K'.

def get_card_value(card)
  card_values = {
    2 => 2, 3 => 3, 4 => 4, 5 => 5,
    6 => 6, 7 => 7, 8 => 8, 9 => 9, 10 => 10, 
    "J" => 10, "Q" => 10, "K" => 10, "A" => 11
  }
  card_values[card]
end # returns that number value of a card, eg: 5

def get_hand_value(cards)
  value = 0
  cards.each { |card| value += get_card_value(card) }
  if cards.include?("A")
    while value > 21 && cards.count("A") > 0
      value -= 10
      cards.delete_at(cards.find_index("A"))
    end
  end
  value
end # returns the numerical value of hand, eg: 17.


puts "=> Welcome to Blackjack! Let's get started."

deck = create_deck

# initial deal
player_cards = []
dealer_cards = []
2.times do
  player_cards << deal_card(deck)
  dealer_cards << deal_card(deck)
end

# show user cards
players_hand = get_hand_value(player_cards)
puts "=> You have a #{player_cards[0]} and a #{player_cards[1]} which equals #{players_hand}."
puts "=> Dealer's first card is a #{dealer_cards[0]}"

if players_hand == 21
  puts "Blackjack - You win!"
end

# ask if user wants to hit
begin
  break if players_hand == 21
  puts "=> Would you like to hit? (y/n)"
  hit = gets.chomp
  break if hit == 'n'
  
  player_cards << deal_card(deck)
  players_hand = get_hand_value(player_cards)
  puts "=> Now your cards are #{player_cards}, which equals #{players_hand}."
  
  if players_hand == 21
    puts "=> You win with 21!"
    break
  end
  
  if players_hand > 21
    puts "=> Bust. You lost."
    break
  end
  
end until hit == "n"
 

# dealer's turn
begin
  puts "=> Dealer's cards are #{dealer_cards} which equals #{get_hand_value(dealer_cards)}."
  break if get_hand_value(player_cards) >= 21
  
  if get_hand_value(dealer_cards) < 17
    new_card = deal_card(deck)
    dealer_cards << new_card
    puts "=> Dealer gets #{new_card}. Now dealer has #{get_hand_value(dealer_cards)}."
  end
  
  if get_hand_value(dealer_cards) > 21
    puts "=> Dealer is bust. You win!"
    break
  end
  
  if get_hand_value(dealer_cards) == 21
    puts "=> Dealer wins with 21!"
    break
  end
end until get_hand_value(dealer_cards) >= 17

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

