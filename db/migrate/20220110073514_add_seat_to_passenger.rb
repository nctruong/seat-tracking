class AddSeatToPassenger < ActiveRecord::Migration[6.1]
  def change
    add_column :passengers, :seat, :string
  end
end
