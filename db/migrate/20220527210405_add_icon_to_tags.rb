class AddIconToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :icon, :string
  end
end
