class RunController < ApplicationController

    #This function will run at the start of every game 
    def create_game
        # Player.destroy_all
        # Deck.destroy_all
        # create deck
        # Start a new game with deck
        g1 = Game.new()
        g1.save
        deck1 = Deck.new(game_id:g1[:id])
        deck1.save
        # Add a game to deck
        deck1.update(game_id:g1.id)
        Card.destroy_all
        # Create all card
        create_cards(deck1.id)
        Deck.shuffle_cards
        # create_dealer
        return g1
    end
    
    def create_cards(deck_id)
        card_suits = ["Diamond", "Spade", "Club", "Heart"]
        card_suits.each{|suit| create_card_from_suite(suit, deck_id)}
    end

    def create_card_from_suite(suit, deck_id)
        loop_value = 1
        card_second_value = nil
        card_value = 0
        13.times do
            loop_value += 1
            if loop_value <= 10
            card_value = loop_value
            card_type = "#{card_value}"
            elsif loop_value == 11
                card_type = 'Jack'
                card_value = 10
            elsif loop_value == 12
                card_value = 10
                card_type = 'Queen'
            elsif loop_value == 13
                card_value = 10
                card_type = 'King'
            elsif loop_value == 14
                card_value = 11
                card_type = 'Ace'
                card_second_value = 1
            end
            c1 = Card.new(card_type: card_type, card_value: card_value, card_second_value: card_second_value, card_suit: suit, deck_id: deck_id, is_in_deck: true)
            c1.save  
        end
    end
end
