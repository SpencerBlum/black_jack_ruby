class PlayersController < ApplicationController

    def self.create_player(name, game_id, is_dealer = false)
        player = Player.new(player_name: name, isDealer: is_dealer)
        player.save
        puts player
        player_game = PlayerGame.new(player_id: player.id, game_id: game_id)
        player_game.save
        if(player.valid?)
            return player
        else 
            return 500
        end
    end
end
