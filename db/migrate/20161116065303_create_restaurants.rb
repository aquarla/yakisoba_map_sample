class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :address2
      t.string :phone
      t.decimal :latitude, precision: 11, scale: 8
      t.decimal :longitude, precision: 11, scale: 8
      t.text :open_and_close
      t.text :regular_holiday
      t.text :seats
      t.text :access

      t.references :prefecture
      t.references :yakisoba_type
      
      t.timestamps
    end
  end
end
