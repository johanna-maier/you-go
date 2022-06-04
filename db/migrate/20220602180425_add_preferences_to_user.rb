class AddPreferencesToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :preferences, :integer, array: true, default: []
  end
end
