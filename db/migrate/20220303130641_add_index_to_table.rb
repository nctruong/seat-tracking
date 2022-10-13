class AddIndexToTable < ActiveRecord::Migration[6.1]
  def change
    add_index :passengers, :active
    add_index :passengers, :sent_cloud
    add_index :passengers, :boarding_pass
    add_index :passengers, :check_in_time
  end
end
