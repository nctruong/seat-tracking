class AddSentCloudToPassenger < ActiveRecord::Migration[6.1]
  def change
    add_column :passengers, :sent_cloud, :boolean, default: false
  end
end
