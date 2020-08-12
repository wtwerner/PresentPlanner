class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :name
      t.integer :price
      t.text :gift_url
      t.text :img_url
      t.text :description
      t.text :note
      t.integer :list_id
    end
  end
end
