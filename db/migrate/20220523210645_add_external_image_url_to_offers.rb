class AddExternalImageUrlToOffers < ActiveRecord::Migration[6.1]
  def change
    add_column :offers, :external_image_url, :string
  end
end
