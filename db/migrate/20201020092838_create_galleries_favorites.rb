class CreateGalleriesFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :galleries_favorites do |t|
      t.integer :user_id
      t.integer :gallery_id

      t.timestamps
    end
  end
end
