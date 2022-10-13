class AddLoadInstructionJobToTrip < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :load_ins_job_id, :string
  end
end
