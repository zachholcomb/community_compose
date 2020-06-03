class AddInfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :about, :string
    add_column :users, :interests, :string
    add_column :users, :instruments, :string
  end
end
