class CreateOffers < ActiveRecord::Migration[6.1]
  def change
    create_table :offers do |t|
      t.string :title
      t.text :description
      t.integer :price_per_person
      t.integer :capacity
      t.string :address
      t.float :latitude
      t.float :longitude
      t.boolean :is_external
      t.string :url
      t.date :offer_date
      t.time :offer_time

      t.timestamps
    end
  end
end
