class AddDateOfReturnToBorrows < ActiveRecord::Migration
  def change
    add_column :borrows, :date_of_return, :date
  end
end
