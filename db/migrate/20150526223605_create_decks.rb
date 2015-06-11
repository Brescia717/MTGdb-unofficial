class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string     :name
      t.string     :mtg_format
      t.text       :library
      t.integer    :user_id, index: true

      t.timestamps null: false
    end
  end
end
