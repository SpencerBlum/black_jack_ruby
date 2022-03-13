class Card < ApplicationRecord
    belongs_to :deck, optional: true
    belongs_to :hand, optional: true
    has_many :player_cards, dependent: :destroy
    has_many :players, through: :player_cards
end
