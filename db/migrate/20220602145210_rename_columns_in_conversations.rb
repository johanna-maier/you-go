class RenameColumnsInConversations < ActiveRecord::Migration[6.1]
  def change
    rename_column :conversations, :user_id, :author_id
    add_column :conversations, :receiver_id, :integer
    add_column :conversations, :topic, :string
    add_index :conversations, %i[author_id receiver_id], unique: true
  end
end
