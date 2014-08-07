class AddColumnsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :asin, :string
    add_column :products, :title, :string
    add_column :products, :offer_listing, :text
    add_column :products, :offer_summary, :text
  end
end
