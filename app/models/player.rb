class Player < ApplicationRecord
    has_many :player_games, dependent: :destroy
    has_many :games, through: :player_games
    has_many  :player_cards, dependent: :destroy
    has_many :cards, through: :player_cards
    validates :player_name, presence: true
end
