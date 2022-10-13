class AddLoadInstructionTimeToTrip < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :load_ins_time, :datetime
  end
end
