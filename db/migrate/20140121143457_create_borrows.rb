class CreateBorrows < ActiveRecord::Migration
  def change
    create_table :borrows do |t|
      t.integer :user_id
      t.integer :book_id
      t.date :date_of_borrow

      t.timestamps
    end
  end
end
