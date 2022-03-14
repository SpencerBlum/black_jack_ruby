require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  RSpec.describe Game, :type => :model do
    it "is valid with valid attributes" do
      game = Game.new(deck_id: 2)
      expect(game).to be_valid
    end


    # test "Test if games controller is valid" do

    #     game = Game.new(deck_id: 2)
    #     if game.valid?
    #       assert true
    #     else 
    #       assert true
    #     end
    # end
end
