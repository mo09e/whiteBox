class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :title, null: false
      t.references :artist, foreign_key: true
      t.references :gallery, foreign_key: true

      t.timestamps
    end
  end
end
