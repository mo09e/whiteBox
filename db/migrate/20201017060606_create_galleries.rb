class CreateGalleries < ActiveRecord::Migration[5.2]
  def change
    create_table :galleries do |t|
      t.string :name, null: false, default: ""
      t.string :phone_number, null: false, default: ""
      t.string :address, null: false, default: ""
      t.integer :rental_fee, null: false, default: 0
      t.integer :lending_period, null: false, default: 0
      t.string :url, null: false, default: ""
      t.json :images
      t.string :layout
      t.text :note, null: false, default: ""
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
