class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string  :name
      t.string  :colors
      t.string  :mana_cost
      t.integer :cmc
      t.string  :types
      t.string  :subtypes
      t.string  :rarity
      t.text    :text
      t.string  :power
      t.string  :toughness
      t.text    :legalities
      t.text    :printings

      t.timestamps null: false
    end
  end
end
