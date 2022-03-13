class CreateDecks < ActiveRecord::Migration[6.0]
  def change
    create_table :decks do |t|
      t.belongs_to :game

      t.timestamps
    end
  end
end
