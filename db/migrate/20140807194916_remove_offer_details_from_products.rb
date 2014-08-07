class RemoveOfferDetailsFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :offer_listing, :text
    remove_column :products, :offer_summary, :text
  end
end
