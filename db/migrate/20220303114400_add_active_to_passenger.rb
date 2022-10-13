class AddActiveToPassenger < ActiveRecord::Migration[6.1]
  def change
    add_column :passengers, :active, :boolean, default: true
  end
end
