class CreatePlayerGames < ActiveRecord::Migration[6.0]
  def change
    create_table :player_games do |t|
      t.belongs_to :player, null: false, foreign_key: true
      t.belongs_to :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
