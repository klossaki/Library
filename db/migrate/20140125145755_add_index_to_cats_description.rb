class AddIndexToCatsDescription < ActiveRecord::Migration
  def change
    add_index :cats, :description, unique: true
  end
end
