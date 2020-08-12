class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.date :event_date
      t.integer :recipient_id
    end
  end
end
