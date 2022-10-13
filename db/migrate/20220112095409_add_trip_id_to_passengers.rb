class AddTripIdToPassengers < ActiveRecord::Migration[6.1]
  def change
    add_column :passengers, :trip_id, :uuid
  end
end
