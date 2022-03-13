# require_relative '../app/controllers/run_controller.rb'
require_relative './build_game.rb'


cli = BuildGame.new()
cli.run_console