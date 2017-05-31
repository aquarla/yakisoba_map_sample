class CreateUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :urls do |t|
      t.text :title
      t.text :url
      t.belongs_to :url_type
      t.belongs_to :restaurant

      t.timestamps
    end
  end
end
