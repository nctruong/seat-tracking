class AddEndedToTrip < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :ended, :boolean, default: false
  end
end
