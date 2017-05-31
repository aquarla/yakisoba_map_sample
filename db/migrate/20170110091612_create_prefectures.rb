class CreatePrefectures < ActiveRecord::Migration[5.0]
  def change
    create_table :prefectures do |t|
      t.string :name
      t.string :code

      t.timestamps
    end

    add_index :prefectures, :code
  end
end
