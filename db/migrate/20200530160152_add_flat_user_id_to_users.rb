class AddFlatUserIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :flat_id, :string
  end
end
