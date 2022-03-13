require_relative '../app/controllers/run_controller.rb'
require_relative '../app/controllers/players_controller.rb'
require_relative '../app/controllers/player_cards_controller.rb'
require_relative '../app/controllers/games_controller.rb'

require "tty-prompt"
class BuildGame

    @game = nil
    @current_player = nil

    def create_player
        prompt = TTY::Prompt.new
        player_name = prompt.ask("What is your name?", default: ENV["Player"])
        resp = PlayersController.create_player(player_name, @game.id)
        @current_player = resp
        if resp == 500
            puts "Sorry there was an error please try again"
            create_player()
        else
            puts "welcome to the black jack table #{resp.player_name}!"  
        end
    end

    def create_dealer
        resp = PlayersController.create_player("Dealer Joe", @game.id, true)
        if resp == 500
            puts "Sorry there was an error please try again"
            create_player()
        else
            puts "Dealer #{resp.player_name}! is at the table " 
            return resp
        end
    end

    def deal_cards(num_cards_dealt, player)
        resp = PlayerCardsController.add_cards_to_hand(@game, player, num_cards_dealt)
        return resp
    end

    def display_cards(hand_resp, is_dealer = false)
        current_player_type = is_dealer == true ? "Dealer" : "Your"

        puts " "
        puts " "
        puts "#{current_player_type} cards"
        count = 1
        hand_resp["current_hand"].each do |card| 
            puts "Card #{count}: #{card}"
            count +=1
        end
        msg =  hand_resp["bust"] == true ? "Busted!" : ""

        puts "-------------------------"
        puts "Total: #{hand_resp["current_total"]} #{msg}"
        puts "-------------------------"
        puts " "
        puts " "
    end

    def check_black_jack(player_hand, dealer_hand)
        if player_hand["black_jack"] == true && dealer_hand["black_jack"] == true
            puts 'PUSH no one wins the game'
            return true
        elsif  player_hand["black_jack"] == true
            puts "|||||||||||||||||||||||||"
            puts "|||||||||||||||||||||||||"
            puts "BLACK JACK Congrats you are a winner!!!"
            puts "|||||||||||||||||||||||||"
            puts "|||||||||||||||||||||||||"
            return true
        elsif dealer_hand["black_jack"] == true
            puts "|||||||||||||||||||||||||"
            puts "|||||||||||||||||||||||||"
            puts "Sorry the dealer won the game"
            puts "|||||||||||||||||||||||||"
            puts "|||||||||||||||||||||||||"
            return true
        end
        return false
    end

    def hit_or_stay
        prompt = TTY::Prompt.new
        hit_stay = prompt.select("Do you want to hit or stay?", %w(Hit Stay))
        if hit_stay == "Hit"
            hand_resp = PlayerCardsController.hit_player(@game, @current_player.id)
            display_cards(hand_resp["dealer"], true)
            display_cards(hand_resp["player"])
            if hand_resp["player"]["bust"] == false && hand_resp["player"]["current_total"] < 21
                hit_or_stay() 
            elsif  hand_resp["player"]["bust"]
                return "Bust"
            else
                puts 'lets see the dealer cards'
            end 
        elsif hit_stay == "Stay"  
            puts 'You stayed, lets see what the dealer has'
        end

    end

    def hit_dealer
        hit_dealer_resp_array = PlayerCardsController.hit_dealer(@game.id, @current_player.id)
        hit_dealer_resp_array.each do |resp|
            display_cards(resp["player"])
            display_cards(resp["dealer"], true)
        end
    end

    def check_winner
        get_winner = GamesController.get_winner(@game.id, @current_player.id)
        puts "|||||||||||||||"
        puts "|||||||||||||||"
        puts "||Game Result||"
        puts "|||||||||||||||"
        puts "||||||#{get_winner}|||||||||"
        puts "|||||||||||||||"

    end

    def run_game
        puts 'Loading Game'
            createGame = RunController.new() 
            @game = createGame.create_game
            puts @game.attributes
            dealer = create_dealer()
            create_player()
            hand_resp = deal_cards(2, @current_player)
            display_cards(hand_resp["dealer"], true)
            display_cards(hand_resp["player"])
            black_jack = check_black_jack(hand_resp["player"], hand_resp["dealer"])
            # continue game if no blackjack
            if black_jack == false
                resp = hit_or_stay()
                if resp == 'Bust'
                    puts 'End game you busted'
                else
                    if hand_resp["dealer"]["current_total"] < 17 
                        hit_dealer()
                    end
                    puts "time to get results"
                    check_winner()
                end     
            end  
    end

    def run_console
        prompt = TTY::Prompt.new
        game_status = prompt.select("Do you want to start a new game of BlackJack?", %w(startGame endGame))
        case game_status
        when 'startGame'
            run_game()  
        else
        "Error: status is invalid (#{game_status})"
        end
    end
end 