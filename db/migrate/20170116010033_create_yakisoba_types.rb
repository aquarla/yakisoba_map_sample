class CreateYakisobaTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :yakisoba_types do |t|
      t.string :name
      t.string :code

      t.timestamps
    end

    add_index :yakisoba_types, :code 
  end
end
