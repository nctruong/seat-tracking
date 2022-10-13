class AddTripIdToTrip < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :trip_id, :string
  end
end
