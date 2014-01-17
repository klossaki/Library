class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn
      t.integer :author_id
      t.integer :cat_it
      t.integer :copies
      t.integer :rank

      t.timestamps
    end
  end
end
