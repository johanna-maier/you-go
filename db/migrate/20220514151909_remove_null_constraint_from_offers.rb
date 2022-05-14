class RemoveNullConstraintFromOffers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :offers, :user_id, true
  end
end
