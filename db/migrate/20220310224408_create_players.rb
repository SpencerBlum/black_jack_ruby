class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :player_name
      t.boolean :isDealer, :default => false

      t.timestamps
    end
  end
end
