class AddTagToOffers < ActiveRecord::Migration[6.1]
  def change
    add_reference :offers, :tag, null: false, foreign_key: true
  end
end
