class AddPassportIndexToPassenger < ActiveRecord::Migration[6.1]
  def change
    add_index :passengers, :passport
  end
end
