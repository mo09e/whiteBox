class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :artist_id
      t.integer :gallery_id

      t.timestamps
    end
  end
end
