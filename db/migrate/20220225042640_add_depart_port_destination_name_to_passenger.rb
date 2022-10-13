class AddDepartPortDestinationNameToPassenger < ActiveRecord::Migration[6.1]
  def change
    add_column :passengers, :depart_port_destination_name, :string
    add_column :passengers, :depart_port_origin_name, :string
  end
end
