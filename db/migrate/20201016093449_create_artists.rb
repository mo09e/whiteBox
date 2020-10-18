class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name, null: false, default: ""
      t.string :phone_number, null: false, default: ""
      t.string :url, null: false, default: ""
      t.json :images
      t.text :note, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
