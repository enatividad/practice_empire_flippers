class CreateListings < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :listings, id: :uuid do |t|
      t.string :listing_status
      t.integer :listing_number
      t.integer :listing_price
      t.text :summary
      t.datetime :a__created_at
      t.boolean :x__is_in_hubspot, null: false, default: false

      t.timestamps
    end
  end
end
