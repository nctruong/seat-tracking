class CreatePassengers < ActiveRecord::Migration[6.1]
  def change
    create_table :passengers do |t|
      t.string :name
      t.boolean :confirmed
      t.string :passport
      t.string :phone
      t.string :boarding_pass
      t.integer :deck
      t.string :trip_no
      t.timestamps
    end
  end
end
