class PlayerCardsController < ApplicationController

    def self.add_cards_to_hand(game, player, cards_dealt)
        updated_player = Player.find_by(id:player.id)
        game = Game.find_by(id:game.id)
        dealer = game.players.find_by(isDealer: true)

        player_cards = Deck.get_num_of_cards(cards_dealt)    
        player_cards.each do |card|
            new_hand = PlayerCard.new(player_id: player.id, card_id: card.id)
            new_hand.save
            card.update(is_in_deck: false)
            Deck.remove_n_cards_from_deck()
        end

        dealer_cards = Deck.get_num_of_cards(cards_dealt)
        dealer_cards.each do |card|
            new_hand = PlayerCard.new(player_id: dealer.id, card_id: card.id)
            new_hand.save
            card.update(is_in_deck: false)
            Deck.remove_n_cards_from_deck()
        end
        player_dealer_resp = {
        "player" => game.check_current_hand(updated_player.cards),
        "dealer" => game.check_current_hand(dealer.cards),
        }
        return  player_dealer_resp
    end

    def self.hit_player(game_id, player_id) 
        player = Player.find_by(id:player_id)
        game = Game.find_by(id:game_id)
        dealer = game.players.find_by(isDealer: true)
        pulled_card = Deck.get_num_of_cards(1)    
        new_card_in_hand = PlayerCard.new(player_id: player_id, card_id: pulled_card[0].id)
        new_card_in_hand.save
        pulled_card[0].update(is_in_deck: false)
        Deck.remove_n_cards_from_deck()

        player_dealer_resp = {
            "player" => game.check_current_hand(player.cards),
            "dealer" => game.check_current_hand(dealer.cards),
            }
        return player_dealer_resp
    end

    def self.hit_again(dealer, pulled_card)
        new_card_in_hand = PlayerCard.new(player_id: dealer.id, card_id: pulled_card[0].id)
        new_card_in_hand.save
        pulled_card[0].update(is_in_deck: false)
        Deck.remove_n_cards_from_deck()
    end

    def self.hit_dealer(game_id, player_id)
        player = Player.find_by(id:player_id)
        game = Game.find_by(id:game_id)
        dealer = game.players.find_by(isDealer: true)
        pulled_card = Deck.get_num_of_cards(1)  
        player_dealer_resp = []

        self.hit_again(dealer, pulled_card)

        dealer_hand = game.check_current_hand(dealer.cards)
        player_dealer_obj = {
            "player" => game.check_current_hand(player.cards),
            "dealer" => dealer_hand,
        }  
        
        player_dealer_resp = player_dealer_resp.push(player_dealer_obj)
        while player_dealer_obj["dealer"]["current_total"] < 17 do
            self.hit_again(dealer, pulled_card)
            player_dealer_resp = player_dealer_resp.push(player_dealer_obj)
        end
        return player_dealer_resp
    end
end
