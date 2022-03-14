class Game < ApplicationRecord
    has_many :player_games
    has_many :players, through: :player_games

    def hand_value_and_card_string(player_cards)
        total = 0
        dic = {}
        card_types = []
        player_cards.each do |card|
            potential_total = total + card.card_value
            card_value = card.card_value
            if card.card_second_value != nil && potential_total > 21
                card_value = card.card_second_value
            end
            total += card_value 
            dic["total"] = total
            card_types.push("#{card.card_type} of #{card.card_suit}s")
        end
        dic["current_hand"] = card_types
        return dic
    end

    def check_current_hand(player_cards)
        total_and_string = hand_value_and_card_string(player_cards)
        black_jack = false
        bust = false
        if total_and_string["total"] == 21 && player_cards.length() == 2
            black_jack = true
        elsif  total_and_string["total"] > 21
            bust = true
        end
        dic = {
            "current_total" =>  total_and_string["total"],
            "black_jack" =>  black_jack,
            "current_hand" => total_and_string["current_hand"],
            "bust" => bust,
        }
        return dic
    end

    def game_winner(dealer_cards, player_cards)
        player_hand = check_current_hand(player_cards)
        dealer_hand = check_current_hand(dealer_cards)

        if dealer_hand["bust"] && !player_hand["bust"]
            return "Dealer busted you won the game!"
        elsif player_hand["current_total"] > dealer_hand["current_total"]
            return "You won the game with the highest hand"
        elsif dealer_hand["current_total"] > player_hand["current_total"]
            return "Sorry the dealer won with the highest hand"
        elsif dealer_hand["current_total"] == player_hand["current_total"]
            return "PUSH you and the dealer ended with the same hand"
        end
        return "there was an error in calculating the winner"
    end
end
