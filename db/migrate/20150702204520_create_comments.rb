class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.belongs_to :commentable, polymorphic: true
      t.integer :user_id, null: false

      t.timestamps null: false
    end
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
