class AddParticipantsToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :participants, :integer
  end
end
