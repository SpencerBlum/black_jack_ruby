class Deck < ApplicationRecord
    belongs_to :game
    has_many :cards
    @deck_of_cards = nil

    def self.shuffle_cards
        shuffled_cards = Card.all.shuffle
        @deck_of_cards = shuffled_cards.select{|card| card.is_in_deck != false} 
    end

    def self.get_num_of_cards(num)
    # grab n cards from top of the deck
    @deck_of_cards.take(num)
        return @deck_of_cards.take(num)
    end

    def self.remove_n_cards_from_deck() 
            @deck_of_cards.shift()
    end
end
