class AddCountryToTrip < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :port_destination_country, :string
    add_column :trips, :port_origin_country, :string
  end
end
