class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :name
      t.integer :price
      t.string :url
      t.text :description
      t.text :note
      t.integer :list_id
      t.integer :recipient_id
    end
  end
end
