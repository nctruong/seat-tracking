class CreateTrips < ActiveRecord::Migration[6.1]
  def change
    create_table :trips, id: :uuid do |t|
      t.string :port_origin_id
      t.string :port_origin_name
      t.string :port_destination_id
      t.string :port_destination_name
      t.string :depart_date
      t.string :etd
      t.string :arrival_date
      t.string :eta
      t.string :vessel_name
      t.integer :available_seats
      t.integer :capacity_seats

      t.timestamps
    end
  end
end
