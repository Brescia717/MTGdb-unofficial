class AddExtraInfoToCards < ActiveRecord::Migration
  def change
    add_column :cards, :card_set,     :string
    add_column :cards, :set_code,     :string

    add_column :cards, :release_date, :date
    add_column :cards, :multiverseid, :integer, unique: true, null: false
    add_column :cards, :card_number,  :integer
    add_column :cards, :flavor,       :string
    add_column :cards, :artist,       :string

    add_column :cards, :image_url,    :string
    add_column :cards, :hi_image_url, :string
  end
end
