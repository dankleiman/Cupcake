class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :product_id
      t.integer :price
      t.integer :inventory

      t.timestamps
    end
  end
end
