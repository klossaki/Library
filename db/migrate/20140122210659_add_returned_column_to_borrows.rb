class AddReturnedColumnToBorrows < ActiveRecord::Migration
  def change
    add_column :borrows, :returned, :boolean, :default => false
  end
end
