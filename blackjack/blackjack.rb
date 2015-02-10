# build deck
# deal cards
# player hit?
#   wins if 21
#   bust if >21
# dealer hit if <17
#   dealer wins if 21
#   dealer bust if >21
# check for winner
# play again

def create_deck
  deck = []
  8.times do 
    (1..9).each { |value| deck << value }
    ["J", "Q", "K", "A"].each { |value| deck << value }
  end
  deck
end # returns deck as array like [1, 2, 3].

def deal_card(deck)
  deck.delete_at(rand(deck.length))
end # returns one card value like '1' or 'K'.

def get_card_value(card)
  card_values = {}
  (1..9).each { |number| card_values[number] = number }
  ["J", "Q", "K"].each { |letter| card_values[letter] = 10 }
  card_values["A"] = 11
  card_values[card]
end

def get_hand_value(cards)
  value = 0
  cards.each { |card| value += get_card_value(card) }
  value
  # if value ace and over 21, subtract 10
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
puts "=> You have a #{player_cards[0]} and a #{player_cards[1]}."
puts "=> Dealer's first card is a #{dealer_cards[0]}"

# ask if user wants to hit
begin
  puts "=> Would you like to hit? (y/n)"
  hit = gets.chomp
  break if hit == 'n'
  player_cards << deal_card(deck)
  puts "Now your cards are #{player_cards}, which equals #{get_hand_value(player_cards)}."
  # check value of player's cards, win/bust if 21 >.
end until hit == "n"