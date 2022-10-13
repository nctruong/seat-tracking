class AddCheckInTimeToPassenger < ActiveRecord::Migration[6.1]
  def change
    add_column :passengers, :check_in_time, :string
  end
end
