class GamesController < ApplicationController

    def self.get_winner(game_id, player_id)
        player = Player.find_by(id:player_id)
        game = Game.find_by(id:game_id)
        dealer = game.players.find_by(isDealer: true)
        dealer_cards = dealer.cards.where(deck_id: game.deck_id)
        player_cards = player.cards.where(deck_id: game.deck_id)
        game_winner = game.game_winner(dealer_cards, player_cards)
        return game_winner
    end
end
