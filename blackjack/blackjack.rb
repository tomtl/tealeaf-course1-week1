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
  card = deck.delete_at(rand(deck.length))
end # returns one card value like '1' or 'K'.


create_deck

player_cards = []
dealer_cards = []

# initial deal
2.times do
  player_cards << deal_card(deck)
  dealer_cards << deal_card(deck)
end

# show user cards
puts "=> you have a #{player_cards[0]} and a #{player_cards[1]}."
puts "=> Dealer's first card is a #{dealer_cards[0]}"

# ask if user wants to hit
begin
  puts "=> Would you like to hit? (y/n)"
  hit = gets.chomp
  
end while hit == "y"