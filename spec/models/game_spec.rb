require 'spec_helper'

RSpec.describe Game, :type => :model do
    it "is valid with valid attributes" do
      game = Game.new(deck_id: 2)
      expect(game).to be_valid
    end
end

