class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :books, :cat_it, :cat_id
  end
end
