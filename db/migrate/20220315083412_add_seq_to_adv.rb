class AddSeqToAdv < ActiveRecord::Migration[6.1]
  def change
    add_column :advs, :seq, :float
    add_column :advs, :playing, :boolean, default: false
  end
end
