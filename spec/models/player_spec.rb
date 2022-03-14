  require 'spec_helper'

RSpec.describe Player, :type => :model do
    it "is valid with valid attributes" do
      new_player = Player.new(player_name: "spencer")
      expect(new_player).to be_valid
    end
end

RSpec.describe Player, :type => :model do
    game = Game.new(deck_id:1)
    card_one = Card.new(card_type: 'Ace', card_value: 11, card_second_value: 1, card_suit: "Spade", deck_id: 1, is_in_deck: false)
    card_two = Card.new(card_type: 'King', card_value: 10, card_second_value: nil, card_suit: "Spade", deck_id: 1, is_in_deck: false)
    card_three = Card.new(card_type: '5', card_value: 5, card_second_value: nil, card_suit: "Spade", deck_id: 1, is_in_deck: false)
    it "display correct total of cards for Ace and King in hand of 21" do
        resp = game.hand_value_and_card_string([card_one,card_two])
        expect(resp["total"]).to equal(21)
        expect(resp["total"]).not_to equal(11)
    end
    it "display correct total of cards for Ace, King, and 5 in hand of 16" do
        resp = game.hand_value_and_card_string([card_three,card_two,card_one])
        expect(resp["total"]).to equal(16)
        expect(resp["total"]).not_to equal(26)
    end
end