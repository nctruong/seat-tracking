class AddEndInsTimeToTrip < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :end_ins_time, :datetime
  end
end
