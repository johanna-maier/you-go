class RenameParticipantsColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :bookings, :participants, :number_of_participants
  end
end
