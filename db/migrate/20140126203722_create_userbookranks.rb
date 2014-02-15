class CreateUserbookranks < ActiveRecord::Migration
  def change
    create_table :userbookranks do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :rank

      t.timestamps
    end
  end
end
