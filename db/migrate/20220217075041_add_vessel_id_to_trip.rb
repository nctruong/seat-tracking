class AddVesselIdToTrip < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :vessel_id, :string
  end
end
