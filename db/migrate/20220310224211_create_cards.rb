class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :card_type
      t.integer :card_value
      t.string :card_suit
      t.integer :card_second_value
      t.boolean :is_in_deck, :default => false 
      t.belongs_to :deck
      
      t.timestamps
    end
  end
end
