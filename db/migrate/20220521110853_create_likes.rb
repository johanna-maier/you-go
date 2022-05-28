class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :offer, null: false, foreign_key: true
      t.timestamps
      t.index [:user_id, :offer_id], unique: true   # Preventing the same user from liking the same post
    end
  end
end
