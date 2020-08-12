class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.string :name
      t.string :relationship
      t.integer :birth_month
      t.integer :birth_day
      t.integer :user_id
    end
  end
end
