class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :family_name, :string
    add_index :users, [:first_name, :family_name], unique: true
  end
end
