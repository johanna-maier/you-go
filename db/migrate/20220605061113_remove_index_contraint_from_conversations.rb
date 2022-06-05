class RemoveIndexContraintFromConversations < ActiveRecord::Migration[6.1]
  def change
    remove_index "conversations", column: [:author_id, :receiver_id], name: "index_conversations_on_author_id_and_receiver_id"
  end
end
